## Debian and Raspberry Pi miscellany
### Tricks
#### Installing Python packages:

- [Priceless advice](https://unix.stackexchange.com/questions/508293/debian-installing-a-python-package-apt-get-or-apt-src)

- Checking:
```
$ apt-cache madison mutagen
$ apt showsrc mutagen
```
- Installing:
```
$ sudo apt install python3-mutagen
```

#### Troubleshooting sudo:

- A failure (user already exists):
```
$ sudo echo "Hello!"
[sudo] password for user:

Username is not in the sudoers file. This incident will be reported.
```
- A remedy:
```
# apt-get install sudo -y    # May be already there
# gpasswd -a user sudo
# chmod 0440 /etc/sudoers
```
- Reboot:
```
$ groups
... sudo ...
```

#### Troubleshooting Guest Additions:

- Add and configure, [Step by Step](https://www.linuxbabe.com/desktop-linux/how-to-install-virtualbox-guest-additions-on-debian-step-by-step):
```
$ sudo apt-get install build-essential module-assistant
$ sudo m-a prepare
# sh /media/cdrom0/VBoxLinuxAdditions.run
```
- In case of successful build, the final `VirtualBox Guest Additions: modprobe vboxsf failed` message can be ignored; reboot

### Rasbperry Pi Desktop on VirtualBox

#### (Arch) Linux Host:

-  Install VirtualBox as per instruction

- Create `vboxsf` group by installing `virtualbox-guest-utils`

- `$ sudo gpasswd -a user vboxsf`; relogin

#### Raspberry Pi Desktop (Debian) Guest:

- Create an appropriate virtual machine; check [*Raspberry Pi Desktop*](https://www.raspberrypi.org/downloads/) architecture, as a 32-bit distribution runs *almost*  fine on a 64-bit virtual machine :smile:

- Install and update *Raspberry Pi Desktop* (Debian)

- Download [Guest Additions (6.0.4 here)](https://download.virtualbox.org/virtualbox/6.0.4/VBoxGuestAdditions_6.0.4.iso), insert them into the virtual CD drive, and install:
```
# sh /media/cdrom0/VBoxLinuxAdditions.run
```

- In case you want to change screen resolution:
```
# nano /etc/default/grub
```
```
GRUB_GFXMODE=1152x864x32   # or something
```
```
# update-grub
```

- In case you cannot enter your shared folder(s):
```
$ sudo usermod -aG vboxsf pi
```

- In case you want to see more:
```
$ sudo VBoxControl sharedfolder list
```