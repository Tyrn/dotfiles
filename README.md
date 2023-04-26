# Linux workstation config

Via [Chezmoi](https://www.chezmoi.io/)

- Install:
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
- TODO: A full set of necessary groups to deps-install (q)
