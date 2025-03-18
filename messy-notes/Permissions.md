## Check and correct permissions on system directories

```
$ yay -Sy pacutils
```
Check:
```
$ yay  -Qq | sudo pacman -Qkk
```
Repair:
```
find /var | sudo pacrepairfile --uid --gid --mode
```

