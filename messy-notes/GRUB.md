## Configure GRUB

_In case you aren't happy with the defaults_

- Make the necessary changes to `/etc/default/grub`.
  All the entries can be safely added to the end of file,
  duplication is allowed.

```
GRUB_TIMEOUT_STYLE=menu
GRUB_DISABLE_BOOTNEXT=true
```

optional (a possible place for pics `/usr/share/grub/themes/`):

```
GRUB_BACKGROUND="/.../my.png"
```

- Enable standard RAM tests

```
sudo pacman -S memtest86+-efi
```

- Update GRUB to enable the changes

```
sudo update-grub
```

or

```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
