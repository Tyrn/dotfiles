## Emacs
### Doom Emacs

- [Project](https://github.com/doomemacs/doomemacs)
- [Personal Configuration](https://github.com/Tyrn/.doom.d)
- Cheat Sheets: [1](https://github.com/niyumard/Doom-Emacs-Cheat-Sheet), [2](https://gist.github.com/hjertnes/9e14416e8962ff5f03c6b9871945b165), [Ultimate](https://naghdbishi.ir/Doom-Emacs-Cheat-Sheet/README.html)

#### Install
- Extras:
```
$ yay -S python-lsp-server
$ yay -S pyright
$ yay -S rust-analyzer
$ yay -S texlab
```
- Emacs client executable (for i3):
```
~ ᐅ cat /usr/local/bin/e-doom
#!/usr/bin/env bash
exec emacsclient --alternate-editor= --create-frame
```
- Add to `~/.xprofile`:
```
export PATH=$PATH:$HOME/.emacs.d/bin
```
```
$ cd ~
$ rm -rf .emacs.d/
$ rm -rf .doom.d/
$ git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
$ yay -S emacs
$ doom install
```

### Troubleshoot

- [Stale elc files](https://github.com/doomemacs/doomemacs/issues/4171):
```
$ rm -rf ~/.emacs.d/.local/straight/build*/*
$ doom sync
```

#### Miscellany

#### Obsolete
##### AUCTeX bug (?): no stepping through the compilation errors

`/etc/texmf/web2c/texmf.cnf`:

`file_line_error_style = f`

to

`file_line_error_style = t`

##### AUCTeX, Okular, forward and inverse search

`okular --unique %o#src:%n`pwd`/./%b`

##### geben, xdebug

`.emacs`:

`(autoload 'geben "geben" "PHP Debugger on Emacs" t)`

`/etc/php/conf.d/xdebug.ini`:
```
zend_extension=/usr/lib/php/modules/xdebug.so
xdebug.remote_enable=on
xdebug.remote_host=localhost
xdebug.remote_port=9000
xdebug.remote_handler=dbgp
```
Usage:

http://localhost/bimbo/test.php?XDEBUG_SESSION_START=1

##### Spacemacs

https://github.com/artempyanykh/evil-russian
