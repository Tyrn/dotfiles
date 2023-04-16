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

- 2023-04-16: do NOT enable ibus-custom.service.
