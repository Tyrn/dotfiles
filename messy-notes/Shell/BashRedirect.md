# Bash Redirection Operators

Here is a table of Bash redirection operators, grouped by the stream they affect and the direction of the data flow.

## 📥 Input Redirections

| Operator       | Meaning                                                  | Notes                                                    |
| -------------- | -------------------------------------------------------- | -------------------------------------------------------- |
| `< file`       | Redirect stdin (fd 0) from `file`                        | The command reads from the file instead of the keyboard. |
| `<> file`      | Open `file` for both reading and writing on stdin        | Rarely used; the file is not truncated.                  |
| `<< word`      | Here document: feed stdin until a line containing `word` | Multiline inline input.                                  |
| `<<< "string"` | Here string: feed `string` as stdin                      | Single-line inline input.                                |
| `n< file`      | Redirect fd `n` from `file`                              | Same as `<` but for an explicit descriptor.              |
| `n<&m`         | Make fd `n` a copy of fd `m` (input side)                | E.g. `3<&0` duplicates stdin onto fd 3.                  |
| `n<&-`         | Close fd `n` (input side)                                | E.g. `0<&-` closes stdin.                                |

## 📤 Output Redirections

| Operator   | Meaning                                           | Notes                                                     |
| ---------- | ------------------------------------------------- | --------------------------------------------------------- |
| `> file`   | Redirect stdout (fd 1) to `file`                  | Truncates `file` to zero length first.                    |
| `>> file`  | Append stdout to `file`                           | Creates the file if it does not exist.                    |
| `n> file`  | Redirect fd `n` to `file`                         | Same as `>` but for an explicit descriptor.               |
| `n>&m`     | Make fd `n` a copy of fd `m` (output side)        | E.g. `2>&1` duplicates stdout onto stderr.                |
| `n>&-`     | Close fd `n` (output side)                        | E.g. `2>&-` closes stderr.                                |
| `&> file`  | Redirect **both** stdout and stderr to `file`     | Bash shorthand for `> file 2>&1`.                         |
| `&>> file` | Append **both** stdout and stderr to `file`       | Bash shorthand for `>> file 2>&1`.                        |
| `>\| file` | Redirect stdout to `file`, overriding `noclobber` | Forces truncation even when `set -o noclobber` is active. |

## 🔀 Combined and Special Forms

| Operator       | Meaning                                        | Notes                                                                     |
| -------------- | ---------------------------------------------- | ------------------------------------------------------------------------- |
| `&> file`      | Both stdout and stderr to `file`               | Already listed above; included here for completeness.                     |
| `&>> file`     | Both streams appended to `file`                | Already listed above.                                                     |
| `2>&1`         | stderr to wherever stdout currently points     | The classic "capture both streams" idiom.                                 |
| `1>&2`         | stdout to wherever stderr currently points     | The inverse; used to send normal output to the error stream.              |
| `exec n> file` | Apply the redirection to the **current shell** | Not a one-shot redirection; it persists for the rest of the shell's life. |
| `exec n>&-`    | Close fd `n` in the current shell              | Persistent close.                                                         |

## 🧐 Reading the Table

- **`n`** is a file descriptor number (0, 1, 2, or a custom one like 3).
- **`m`** is another file descriptor number.
- The `&` in `n>&m`, `n<&m`, `n>&-`, `n<&-` is the **parser marker** that says "the following token is a descriptor, not a filename" — the same role described earlier.
- Redirections are applied **left to right**, so order matters: `> file 2>&1` and `2>&1 > file` produce different results.
- `&> file` and `&>> file` are Bash-specific shorthands; in POSIX shells you write `> file 2>&1` and `>> file 2>&1` instead.

## 💡 A Practical Grouping

If you remember only three patterns, remember these:

1. **Send output to a file**: `> file` (overwrite) or `>> file` (append).
2. **Send both streams to a file**: `> file 2>&1` (portable) or `&> file` (Bash).
3. **Feed input from a file**: `< file`, or inline with `<<< "string"` / `<< EOF ... EOF`.

Everything else in the table is a variation on those three, applied to a specific descriptor or with a specific file-open mode.
