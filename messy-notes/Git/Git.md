## GitHub

#### Resources

##### Line endings

- [Eclipse & Git: Mind your Windows line endings!](http://mike.meessen.biz/blog/?p=368)

- [Force LF eol in git repo and working copy](https://stackoverflow.com/questions/9976986/force-lf-eol-in-git-repo-and-working-copy)

- [Dealing with line endings, official](https://help.github.com/articles/dealing-with-line-endings/)

- [**Line ending thing that works**](https://coderwall.com/p/dzdw_a/converting-line-endings-from-dos-carriage-returns-to-unix-line-feeds-using-git)

##### Workflow

- [Git workflow best practices: 5 tips](https://raygun.com/blog/git-workflow/)

- [Merging vs. Rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

- [Collaborating](https://www.atlassian.com/git/tutorials/syncing)

- Change the commentary (message) to the last commit

```
git commit --amend -m "New message"
```

```
git push --force-with-lease
```

#### Rollback

```
$ git reset --hard f6486e8b
$ git reset --soft HEAD@{1}
$ git commit ...
```

#### Credentials on the workstation

- [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

- Generate a public key on your workstation (`~/.ssh/id_rsa.pub`, if you accept all defaults):

```
$ ssh-keygen
```

- Create a new SSH key in GitHub web interface and copy/paste the `~/.ssh/id_rsa.pub` contents

- Say `yes` once asked _Are you sure..._ (the question is never repeated):

```
$ git clone git@github.com: ...
Cloning into ...
The authenticity of host '...' can't be established.
...
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
```
