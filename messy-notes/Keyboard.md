## Keyboard
### Remapping example

[Ubuntu 13.04](https://askubuntu.com/questions/325272/permanent-xmodmap-in-ubuntu-13-04/347382#347382?newreg=4eb097870a15490ebbe39d78412f9797)

- Check with `$ xev`

- Change to `/usr/share/X11/xkb/symbols/pc`:
```
key <MENU> {	[ Menu			]	};
```
to
```
key <MENU> {	[ Alt_R			]	};
```
- Remove precompiled `*.xkm` files from `/var/lib/xkb/`, if any