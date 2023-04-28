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
$ chezmoi apply -v
```
- Enable custom WM for KDE:
```
$ systemctl mask --user plasma-kwin_x11
$ systemctl enable --user plasma-custom-wm.service
```
- Set groups (reboot/relogin afterwards):
```
$ cd ~/.local/share/chezmoi
$ ./groups-add
```
- Install the things `dotfiles` are all about:
```
$ yes | ./deps-install
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
