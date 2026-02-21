# Pacman

## Manage mirrors

_Arch, EndeavourOS, etc. but probably not Manjaro_

- Discussions,
  [1](https://forum.endeavouros.com/t/simple-endeavouros-maintenance-cheat-sheet/72048),
  [2](https://forum.endeavouros.com/t/a-complete-idiots-guide-to-endeavour-os-maintenance-update-upgrade/25184)

- Update Arch mirrors

```
reflector --protocol https --verbose --latest 25 --sort rate | sudo tee /etc/pacman.d/mirrorlist
```

or

```
reflector --protocol https --verbose --latest 25 --sort rate --save /etc/pacman.d/mirrorlist
```

or

```
reflector --protocol https --verbose --latest 25 --sort rate | tee ~/mirrorlist
```

```
sudo mv ~/mirrorlist /etc/pacman.d
```

- Update EndeavourOS mirrors

```
eos-rankmirrors --verbose
```

- Update Chaotic AUR

```
rate-mirrors chaotic-aur | sudo tee /etc/pacman.d/chaotic-mirrorlist
```

or

```
rate-mirrors chaotic-aur | tee ~/chaotic-mirrorlist
```

```
sudo mv ~/chaotic-mirrorlist /etc/pacman.d
```

- Update all

```
yay -Syyu
```

- Clean journal

```
journalctl --vacuum-time=4weeks
```

## Tips and tricks

- List all the packages of a given repository (`sandbox`)

```
pacman -Sl sandbox
```
