# Manjaro Linux workstation config

For Plasma KDE and i3; also good for RPi.

- Install [Chezmoi](https://www.chezmoi.io/):
```
$ sudo pacman -S chezmoi zoxide
```
- Init:
```
$ chezmoi init https://github.com/Tyrn/dotfiles.git
```
The repository is found in `~/.local/share/chezmoi`

- Deploy:
```
$ cp ~/.zshrc ~/.zshrc.old
$ chezmoi apply -v
```
- Enable custom WM for KDE:
```
$ systemctl mask --user plasma-kwin_x11
$ systemctl enable --user plasma-custom-wm.service
```
- Set groups (reboot/relogin afterwards):
```
$ cd ~/.local/share/chezmoi/run-archlinux
run-archlinux $ ./groups-add
```
- Install the things `dotfiles` are all about:
```
run-archlinux $ yes | ./all-install
```
- 2023-04-18: for now it's necessary to add by hand to `/etc/environment`:
```
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
```

*NB* No symlinks so far

## Miscellany

- Control `$ chezmoi add` using `.chezmoiignore`, located in the repository: [#1237](https://github.com/twpayne/chezmoi/issues/1237)

- Stop/start `ibus-daemon` if it hangs:
```
$ ibus exit
$ ibus-daemon -drx &
```
- Change shell, if necessary:
```
$ chsh -s $(which zsh)
$ ps -p $$
$ echo $SHELL
```
- Troubleshooting: [Extra shells](https://unix.stackexchange.com/questions/39881/running-chsh-does-not-change-shell)
```
$ who
danny  pts/0        Nov 6 13:53 (10.1.6.121)
danny  pts/1        Nov 5 12:30 (10.1.6.165)
danny  pts/2        Nov 4 12:33 (10.1.6.197)
$ pkill -KILL -u danny
```
- [Vim spell checking files (.spl, .sug)](https://ftp.nluug.nl/vim/runtime/spell/)

### Git credentials on the workstation

- [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

- Generate a public key on your workstation (`~/.ssh/id_rsa.pub`, if you accept all defaults):
```
$ ssh-keygen
```
- Create a new SSH key in GitHub web interface and copy/paste the `~/.ssh/id_rsa.pub` contents

- Say `yes` once asked *Are you sure...* (the question is never repeated):
```
$ git clone git@github.com: ...
Cloning into ...
The authenticity of host '...' can't be established.
...
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
```

### Android Studio and flutterup

- Make sure *File > Settings > Appearance & Behavior > System Settings > Android SDK > SDK Tools > Android SDK Command Line Tools (latest)* gets checked and installed;

- [flutterup](https://github.com/Decodetalkers/flutterup) and Flutter SDK manual installation
```
$ yay -S flutterup
$ flutterup install
$ flutter doctor
```
- Flutter SDK location (flutterup default)
```
~/.local/share/flutterup
```
- Dart SDK location
```
~/.local/share/flutterup/bin/cache/dart-sdk
```
