# Managing LFS (Large Files Storage)

(1) _how to migrate_; (2) _how to enable_

## (1) Migrating Binary Blobs to Git LFS (Without Duplication)

A step-by-step guide for a chezmoi-managed dotfiles repository.

The goal: move large binaries out of the git object database and
into Git LFS, so that every commit contains only small pointer
files. This reduces the repository's git size and moves the
binaries to LFS storage, which is counted separately.

### Prerequisites

- `git-lfs` installed and initialized (`git lfs install`).
- `chezmoi` installed and working.
- The repository is a chezmoi source directory, typically
  `~/.local/share/chezmoi`.
- All work happens on the machine that will perform the migration.
  Other machines will re-clone afterward.

### Why `--no-rewrite` Is Not Enough

`git lfs migrate import --no-rewrite` adds a new commit that
converts the current state to LFS pointers, but leaves the old
binary blobs in history. The result is duplication: the binaries
exist in both the git object database (old commits) and in LFS.
The repository becomes _larger_, not smaller.

To actually remove the binaries from history, you must **rewrite
history**. That changes commit SHAs, and every other machine must
re-clone. This is the cost of a clean migration.

### Step 1 — Make a Backup

From the parent directory of the chezmoi source:

```
cd ~/.local/share
```

```
rsync -a --info=progress2 chezmoi/ chezmoi.backup-$(date +%Y%m%d)/
```

The trailing slash on `chezmoi/` means "copy the contents."
Keep this backup until the migration is verified on all machines.

### Step 2 — Ensure the Working Tree Is Clean

```
cd ~/.local/share/chezmoi
git status
```

Expect "nothing to commit, working tree clean." If not, stop and
resolve.

Note the current `.git` size for later comparison:

```
du -sh .git/objects
```

### Step 3 — Install and Initialize Git LFS

On Arch Linux:

```
sudo pacman -S git-lfs
```

```
git lfs install
```

`git lfs install` is a one-time-per-user operation. It registers
the LFS filters in `~/.gitconfig`. Without it, Git will check out
pointer stubs instead of real binaries.

### Step 4 — Rewrite History with Git LFS

This is the command that actually does the work. Run it in the
repository:

```
git lfs migrate import --everything --include='*.png,*.jpg,*.fw,*.spl,*.sug,*.bitstream'
```

Adjust the `--include` list to match your binary extensions. The
comma-separated list is one string, not multiple arguments.

What this does:

- Walks every commit in history.
- Replaces matching files with LFS pointers in every commit.
- Removes the old binary blobs.
- Rewrites commit SHAs (unavoidable).

Output looks like:

```
Sorting commits: ..., done.
Rewriting commits: 100% (N/N), done.
main <old-sha> -> <new-sha>
Updating refs: ..., done.
Checkout: ..., done.
```

### Step 5 — Prune Old Objects

The rewrite leaves old objects unreachable but present. Expire
the reflog and garbage-collect:

```
git reflog expire --expire=now --all
```

```
git gc --prune=now --aggressive
```

Then check the size:

```
du -sh .git/objects
```

It should be **much smaller** than the "before" number — typically
a few hundred KB, since history now contains only text commits
and small LFS pointers.

If it's still large, see Troubleshooting.

### Step 6 — Verify Locally

```
git lfs ls-files | wc -l
```

Expect the number of tracked binaries (e.g. 32). Each line should
have a `*` marker, meaning the LFS object is present locally.

```
git status
```

Expect clean.

```
du -sh .git/objects
```

```
du -sh .git/lfs
```

Expect `.git/objects` small (hundreds of KB), `.git/lfs` around
the total size of the binaries.

### Step 7 — Push to the Remote

Re-add the remote if it was removed during the process:

```
git remote -v
```

```
git remote add origin git@github.com:Tyrn/dotfiles.git
```

Force-push (required because commit SHAs changed):

```
git push --force origin main
```

```
git push --force --tags origin
```

or

```
git push --force origin main --tags
```

The push output will show LFS objects uploading separately:

```
Uploading LFS objects: 100% (N/N), <size> | ..., done.
Writing objects: 100% (...), <small-size> ...

<old-sha>...<new-sha> main -> main (forced update)
```

The "Writing objects" line should be a few hundred KB — that's
the payoff.

### Step 8 — Verify on the Remote

On GitHub, click a migrated file (e.g. `kath.jpg`). The header
should say "Stored with Git LFS." The repository's size indicator
in Settings should show a few hundred KB, not the original size.

### Step 9 — Re-clone on Other Machines

Each existing clone has diverged history and cannot pull. On each
other machine, **in this order**:

1. Install `git-lfs`:

```
sudo pacman -S git-lfs
```

2. Initialize it:

```
git lfs install
```

This must come **before** chezmoi touches the repo. Without
it, `chezmoi init --git-lfs` will not fetch the binaries, and
you'll get pointer stubs.

3. Move the old clone aside:

```
cd ~
```

```
mv .local/share/chezmoi .local/share/chezmoi.old
```

4. Re-clone with the LFS flag:

```
chezmoi init --git-lfs git@github.com:Tyrn/dotfiles.git
```

5. Apply:

```
chezmoi apply -v
```

6. Verify:

```
cd ~/.local/share/chezmoi
```

```
git lfs ls-files | wc -l
```

### Step 10 — Clean Up Local Backups

Once at least one other machine is verified working:

```
rm -rf ~/.local/share/chezmoi.backup-*
rm -rf ~/.local/share/chezmoi.pre-migrate-*
```

### Troubleshooting

**`.git/objects` is still large after Step 5**
Something is keeping old objects reachable. Check:

```
git count-objects -vH
```

```
git for-each-ref
```

```
git stash list
```

Any ref or stash pointing to a pre-rewrite commit will keep the
old blobs alive. Remove the offending ref or stash, then re-run
the reflog expire and gc.

**On another machine, binaries are text stubs**
`git lfs install` was not run before cloning. Run it now, then:

```
cd ~/.local/share/chezmoi
```

```
git lfs pull
```

```
git checkout --force
```

```
chezmoi apply -v
```

**`chezmoi init --git-lfs` says "LFS objects not installed"**
Same cause: the LFS filters are not registered. Run
`git lfs install` first.

**A file reports as "ASCII text" instead of its real type**
The smudge filter did not run. Same fix as above.

**`git push` rejected due to branch protection**
Temporarily disable protection in GitHub Settings → Branches,
push, then re-enable.

### The One Rule to Remember

**`git lfs install` must be run on every machine before chezmoi
clones or updates the repository.** It is the step that registers
the LFS filters; without it, everything downstream silently
produces pointer stubs instead of real binaries.

The two things to remember:

- `--no-rewrite` doesn't remove the old blobs — it duplicates them. The real
  migration needs a history rewrite (`git lfs migrate import` without that flag).

- `git lfs install` must precede `chezmoi init --git-lfs` on every
  machine — otherwise chezmoi produces pointer stubs, and the
  binaries are corrupted.

Everything else is verification and cleanup, which is where the
effort should go once the fundamentals are right.

## (2) Enabling Git LFS on a Repository Before the First Binary

This is the easy case. There is no history to rewrite, so no
force-push, no `git filter-repo`, and no re-cloning on other
machines. You simply configure the tracking rules once, commit
them, and every binary added afterwards goes to LFS
automatically.

### Step 1 — Install and initialize Git LFS (one-time per machine)

Install the client:

```
sudo pacman git-lfs
```

Then register the LFS filters in your global Git config:

```
git lfs install
```

This is a one-time-per-user operation. It writes the
`filter.lfs.*` entries into `~/.gitconfig`, which is what makes
Git hand LFS-tracked files to the LFS filter on checkout and
commit.

If you have other machines, run `git lfs install` on each of
them too, once. It is a per-user setting, not per-repository.

### Step 2 — Declare which patterns LFS should track

In the repository (before any binary exists), run one `git lfs
track` per pattern:

```
git lfs track "*.png"
git lfs track "*.jpg"
git lfs track "*.fw"
git lfs track "*.spl"
git lfs track "*.sug"
git lfs track "*.bitstream"
```

Each command appends a line to `.gitattributes` in the
repository root. The line looks like:

```
*.png filter=lfs diff=lfs merge=lfs -text
```

The `-text` at the end tells Git this is a binary, so it should
not attempt line-ending normalization.

You can also track a whole list at once:

```
git lfs track "*.png" "*.jpg" "*.fw" "*.spl" "*.sug" "*.bitstream"
```

### Step 3 — Commit .gitattributes

This is the important step. The tracking rules must be in the
repository, not just on your machine:

```
git add .gitattributes
```

```
git commit -m "Configure Git LFS tracking"
```

Do **not** rely on a global `.gitattributes`. Committing the
file into the repository is what lets fresh clones and forks
pick up the LFS rules automatically.

### Step 4 — Push the .gitattributes commit

```
git push
```

This push contains no binaries, just the rules. It is small and
fast.

### Step 5 — Add your first binary

From this point on, everything matching the tracked patterns
goes to LFS automatically. You do nothing special:

```
git add path/to/image.png
```

```
git commit -m "Add first tracked binary"
```

```
git push
```

On commit, Git LFS replaces the binary in the index with a tiny
text pointer, and the actual content is stored in the LFS cache
at `.git/lfs/objects/`. On push, the pointer goes
into the Git history and the binary uploads to the LFS
endpoint:

```
Uploading LFS objects: 100% (1/1), <size> | ..., done.
Writing objects: 100% (N/N), <small-size> ...
```

### How to Verify

After the first push, check:

```
git lfs ls-files
```

The tracked binary should appear with a `*` marker, meaning the
LFS object is present locally.

On GitHub (or whichever host), click the file. The header
should say "Stored with Git LFS."

### Why This Order Matters

If you add the binary **before** running `git lfs track`, Git
stores the full binary in the repository's history. Fixing that
afterwards requires a history rewrite, which is exactly the
migration you just did on the dotfiles repo. Doing `git lfs
track` first, and committing `.gitattributes` before the first
binary, avoids the rewrite entirely.

The `.gitattributes` commit is what future clones use to know
which files are LFS-managed [citation:4]. It must be in the
repository before the binaries arrive.

### The One-Line Summary

For a repository with no binaries yet:

```
git lfs install
```

```
git lfs track "*.png" "*.jpg" "*.fw" "*.spl" "*.sug" "*.bitstream"
```

```
git add .gitattributes
```

```
git commit -m "Configure Git LFS tracking"
```

```
git push
```

Then add your binaries normally. Everything else is automatic.

The two-line takeaway for future repositories: `git lfs track`
and commit `.gitattributes` before the first binary, and you
never have to rewrite history.
