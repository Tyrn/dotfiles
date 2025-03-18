## CUPS
#### Management
```
$ sudo systemctl enable cups       # cups, not cupsd !!! (?)
```
```
$ sudo systemctl start org.cups.cupsd[.service]
$ systemctl is-enabled org.cups.cupsd
```

#### Xerox Phaser 3117
##### Drivers

- Xerox Phaser 3117, SpliX V. 2.0.0 (grayscale, 2-sided printing), *preferred*.
- Samsung ML-1710
- 2023-05-07:
```
$ yay -S splix
```
