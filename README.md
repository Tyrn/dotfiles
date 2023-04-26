# Manjaro Linux workstation config

For Plasma KDE and i3; also good for RPi.

- Install [Chezmoi](https://www.chezmoi.io/):
```
$ yay -S chezmoi
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
systemctl enable --user plasma-custom-wm.service
```
- Set groups (reboot/relogin afterwards):
```
$ cd ~/.local/share/chezmoi
$ ./groups-add
```
- Install the things `dotfiles` are all about:
```
$ ./deps-install
```

*NB* No symlinks so far

## Miscellany

- Control `$ chezmoi add` using `.chezmoiignore`, located in the repository: [#1237](https://github.com/twpayne/chezmoi/issues/1237)

- Stop/start `ibus-daemon` if it hangs:
```
$ ibus exit
$ ibus-daemon -drx &
```
- 2023-04-18: for now it's necessary to add by hand to `/etc/environment`:
```
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
```
