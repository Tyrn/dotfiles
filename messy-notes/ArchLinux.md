## Arch Linux howto
### Setup
#### Essential procedure, based on the Beginner's Guide

Create USB stick:

`$ sudo dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress && sync`

The case of `/dev/sda`:
```
/dev/sda1 swap
/dev/sda2 /
/dev/sda3 /home
```
archiso login: root (automatic login)
```
# lsblk /dev/sda
# mount /dev/sda2 /mnt
# mkdir /mnt/home
# mount /dev/sda3 /mnt/home
# pacstrap /mnt base
# genfstab -U -p /mnt >> /mnt/etc/fstab
# arch-chroot /mnt
## ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime
## hwclock --systohc --utc
## echo aardbox > /etc/hostname

## pacman -Syy
## pacman -Su

## pacman -S zile
## zile /etc/locale.gen ;; Uncomment the necessary locales
## locale-gen
## localectl set-locale LANG=en_US.UTF-8 ;; can be postponed

## mkinitcpio -p linux
## passwd ;; Set the root password
## pacman -S grub-bios
## grub-install --recheck /dev/sda
## cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
## grub-mkconfig -o /boot/grub/grub.cfg ;; mostly from /etc/default/grub

## pacman -S networkmanager
## exit
# umount /mnt/home
# umount /mnt
# reboot
```
Life After Reboot, Your Very Own System, Using Your root Password
```
# systemctl start NetworkManager
# systemctl enable NetworkManager
;; # pacman -Syy ;; Already done (?)
;; # pacman -Su
# pacman -S tree bash-completion mlocate ntp htop alsa-utils
# pacman -S xf86-input-synaptics                ;; in case of touchpad
# useradd -g users -G wheel -s /bin/bash alexey ;; add user alexey
# pacman -S xorg-server xorg-server-utils xorg-xinit
# pacman -S xf86-video-intel ;; or whatever
# pacman -S xorg-twm xorg-xclock xterm
# startx ;; quit: type exit in each window
# pacman -S sddm plasma[-meta]                  ;; tentative
# systemctl enable sddm.service
# shutdown -r now
```
Life in Plasma From Now On

Tips & Tricks:

* SDDM convenience (`/etc/sddm.conf`):
```
[Autologin]
User=alexey
Session=fluxbox.desktop
[Theme]
Current=archlinux
```
* Locales

`$ locale`

should show en_US.UTF-8 all the way down :) If not, apply again;
the change would show after reboot:

`$ sudo localectl set-locale LANG=en_US.UTF-8`

* Fonts in Wine
```
# pacman -S winetricks
$ winetricks allfonts
```
* Sound in Wine on x86_64
```
# pacman -S lib32-alsa-plugins lib32-libpulse lib32-openal
$ winecfg ;; Wine GUI Settings
```
* Add a User to a Group
`# usermod -a -G audio alexey ;; Relogin to see the effect`

* Chromium Tidbits
Extensions Manager (aka Switcher) v.0.2.1.2
Adblock Plus v.1.4
Greyscale v.1.11
Greyscale Final Touch v.2

* GTK 3 Theme
Adwaita



2015-12-22

* GPT Hard Drive:
```
$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0  2.7T  0 disk 
├─sda1   8:1    0    1M  0 part 
├─sda2   8:2    0  512M  0 part [SWAP]
├─sda3   8:3    0 48.8G  0 part /
└─sda4   8:4    0  2.7T  0 part /home
sr0     11:0    1 1024M  0 rom  
```
`/etc/fstab` (set manually according to `blkid` utility output):
```
# 
# /etc/fstab: static file system information
#
# <file system> <dir>   <type>  <options>       <dump>  <pass>

PARTUUID=cac8c246-... none  swap defaults 0 0
PARTUUID=0f63e259-... /     ext4 rw,relatime,data=ordered 0 1
PARTUUID=b5ff25cf-... /home ext4 rw,relatime,data=ordered 0 2

/home/alexey /export/alexey none bind 0 0
```

GRUB installed on sda the usual way; hopefully, sda1 safely took
the punishment.

#### chroot

```
# fdisk -l ;; root here is essential
# lsblk /dev/sda
# mkdir /mnt/arch
# mount /dev/sda2 /mnt/arch
# mount /dev/sda3 /mnt/arch/home

# cd /mnt/arch
# mount -t proc proc proc/
# mount -t sysfs sys sys/
# mount -o bind /dev dev/
# mount -t devpts pts dev/pts/
# chroot /mnt/arch /bin/bash

## passwd root          ;; or whatever you wish
##
## exit

# umount /mnt/arch/home ;; unmounting is optional
# umount /mnt/arch
```

#### pacman
```
$ sudo pacman -Rscn gnome
$ pacman -Qo /usr/share/apps/kdm/sessions/*.desktop
$ yaourt -S something-from-aur --export ~/my-save-directory
$ sudo pacman -Rsn $(pacman -Qdtq)  # Remove packages no longer in use.
```