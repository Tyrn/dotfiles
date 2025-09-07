# Making life easier with dotfiles

## Manjaro Linux workstation

_As of 2025-03-17, AUR free setup_

- Follow the instructions for [EndeavourOS](#endeavouros)

- [Trouble wit GRUB](https://forum.manjaro.org/t/get-a-black-screen-with-error-grub-is-using-legacy-shim-lock-protocol-not-found/180669/5)
  (_shim lock_ error)
  - Install and run `install-grub` script after first update, and before reboot

  - Otherwise

  ```
  sudo -i
  manjaro-chroot -a
  pacman -S install-grub
  install-grub
  ```

_NB_ If you experience a general trust trouble, [1](https://forum.manjaro.org/t/update-error-failed-to-commit-transaction/150638),
[2](https://forum.manjaro.org/t/error-failed-to-commit-transaction-invalid-or-corrupted-package-pgp-signature/150830)

```
$ sudo pacman-key --init
$ sudo pacman-key --populate archlinux manjaro
$ sudo pacman-key --refresh-keys           ;; This one takes a lot of time!
```

[or](https://forum.manjaro.org/t/pacman-key-refresh-keys-always-hangs-on-the-same-key/143521),
better, run the copy of the [semi-]official script.

```
curl -OL https://github.com/Tyrn/dotfiles/raw/main/run-archlinux/fix-gpg-pacman.sh
```

```
bash fix-gpg-pacman.sh --usage
```

- Later on, see `pacman-add` script on adoption of unofficial repositories

### If you want Plasma KDE + i3 on X11

- Check session type, because you can't have it on Wayland. Must be `x11`

```
echo $XDG_SESSION_TYPE
```

- Enable custom WM for KDE:

```
systemctl mask --user plasma-kwin_x11
```

```
systemctl enable --user plasma-custom-wm.service
```

- Back to KWin:

```
systemctl unmask --user plasma-kwin_x11
```

```
systemctl disable --user plasma-custom-wm.service
```

## EndeavourOS

### Install Sequence

- Install the system from USB stick

- Update the system

```
sudo pacman -Syu
```

- Bootstrap dotfiles

```
sudo pacman -S chezmoi
```

```
chezmoi init https://github.com/Tyrn/dotfiles.git
```

or, if it's your active GitHub account already

```
chezmoi init git@github.com:Tyrn/dotfiles.git
```

- Now the installation scripts are in place. Go to them (you'll need it more than
  once down the road)

```
cd ~/.local/share/chezmoi/run-archlinux
```

- Keep an eye on your installation scripts output. Sometimes you'll
  have to say _yes_ or _Enter_

- Run `./admin-add` (expect reboot)

- Run `./zsh-install`. Answer _yes_ to everything, then leave the new and pretty
  default zsh with Ctrl+D. Wait till the end and close the terminal. Open it any
  time and enjoy [the fun](https://github.com/ohmyzsh/ohmyzsh/wiki).
  - You can reload the shell (zsh) any time without closing the terminal

  ```
  omz reload
  ```

- Run `./all-install`

- Later on, see `pacman-add` on adoption of unofficial repositories, if necessary

### [Gnome tips](messy-notes/GNOME.md)

## Fedora

### Install sequence

- Install the system from USB stick

_NB_ Unlike other GUI installers, the initial system settings belong not to the
installer, but to the first boot. Click anywhere, and you get asked about user
name, password, etc.

- Update the system

```
sudo dnf update --refresh
```

```
sudo dracut -f --regenerate-all
```

- Reboot

- Get fedora-dotfiles

```
curl -OL "https://github.com/Tyrn/dotfiles/raw/main/run-fedora/fedora-dotfiles.sh"
```

- Run the bootstrap script

```
bash fedora-dotfiles.sh
```

_NB_ chezmoi is already installed via mise, zsh-install script relies on that!

- Now the installation scripts are in place. Go to them (you'll need it more than
  once down the road)

```
cd ~/.local/share/chezmoi/run-fedora
```

- Run `./zsh-install`. Answer _yes_ to everything, then leave the new and pretty
  default zsh with Ctrl+D. Wait till the end and close the terminal. Open it any
  time and enjoy [the fun](https://github.com/ohmyzsh/ohmyzsh/wiki).
  - You can reload the shell (zsh) any time without closing the terminal

  ```
  omz reload
  ```

- Run `./all-prepare`, (expect reboot)

_NB_ Among other things, at the end all-prepare sets user groups. Somehow, it takes
a lot of time, up to three minutes.

- Run `./all-install`; it's a longish run, sometimes you'll need to make choices
  (mostly _yes_).

### Fedora tips

- Install/reinstall rustup at will

```
curl https://sh.rustup.rs -sSf | sh
```

- Uninstall rustup (the toolchains will be gone)

```
rustup self uninstall
```

## Update apps installed globally with non-native package managers

- Cargo
  - List all the packages

  ```
  cargo install --list
  ```

  - Update all the packages

  ```
  cargo install-update -a
  ```

- pipx
  - List all the packages

  ```
  pipx list
  ```

  - Update all the packages

  ```
  pipx upgrade-all
  ```

- Mise
  - List all packages

  ```
  mise ls [-g]
  ```

  - Update individually

  ```
  mise use -g app@latest
  ```

- Flatpak
  - List all the apps

  ```
  flatpak list
  ```

  - Update all the apps

  ```
  flatpak update [-y]
  ```

  - Update individually

  ```
  flatpak update com.vscodium.codium
  ```

## Miscellany

_A lot of installation instructions already implemented in scripts,
so unnecessary to execute manually_

- Create a USB stick
  - Plug in, but do not mount the stick; check

  ```
  sudo fdisk -l
  ```

  - If you want to check the stick label

  ```
  sudo blkid -o list
  ```

  - Upload the system to the stick. Be careful about the `of` argument!

  ```
  $ sudo dd bs=4M if=linux.iso of=/dev/sda status=progress && sync
  ```

- [**Assorted notes**](messy-notes)

- Control `$ chezmoi add` using `.chezmoiignore`, located in the repository: [#1237](https://github.com/twpayne/chezmoi/issues/1237)

- Stop/start `ibus-daemon` if it hangs:

```
$ ibus exit
$ ibus-daemon -drx &
```

- Change date and time language; `LC_TIME` in `/etc/locale.conf` (`/etc/default/locale` is ignored):

```
LANG=en_US.UTF-8
...
LC_TIME=en_US.UTF-8

```

- Change shell, if necessary:

```
$ chsh -s $(which zsh)
$ ps -p $$
$ echo $SHELL
```

- Troubleshooting: [Extra shells](https://unix.stackexchange.com/questions/39881/running-chsh-does-not-change-shell)

```
$ who
danny  pts/0        Nov 6 13:53 (10.1.6.121)
danny  pts/1        Nov 5 12:30 (10.1.6.165)
danny  pts/2        Nov 4 12:33 (10.1.6.197)
```

```
pkill -KILL -u $USER
```

- Make GRUB menu visible
  - Change timeout style (`/etc/default/grub`):

  ```
  GRUB_TIMEOUT_STYLE=menu
  ```

  - Update GRUB:

  ```
  $ sudo update-grub
  ```

- Manage AstroNvim
  - [Vim spell checking files (.spl, .sug)](https://ftp.nluug.nl/vim/runtime/spell/)
  - (Re)install AstroNvim

  ```
  ~/.local/share/chezmoi/run-archlinux/nvim-install
  ```

  - Troubleshoot AstroNvim

  ```
  :Lazy update  (<Leader>pU)
  :Lazy sync    (<Leader>pS)
  ```

### Hyprland ML4W

- Installation; **the install script will suggest a** `~/dotfiles` **directory**; **reject, and change it to** `~/ml4w-dotfiles`**!**

```
bash <(curl -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles/main/setup-arch.sh)
```

### Git credentials on the workstation

- [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

- Generate a public key on your workstation (`~/.ssh/id_rsa.pub`, if you accept all defaults):

```
$ ssh-keygen
```

- Create a new SSH key in GitHub web interface and copy/paste the `~/.ssh/id_rsa.pub` contents

- Say _yes_ once asked _Are you sure..._ (the question is never repeated):

```
$ git clone git@github.com: ...
Cloning into ...
The authenticity of host '...' can't be established.
...
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
```

### Church Slavonic keyboard layout

- [Already there](run-archlinux/m17n-add)

- [Slavonic Computing](https://sci.ponomar.net/)

- [Keyboard description](https://www.ponomar.net/files/docen.pdf?_ga=2.125568652.766108792.1757098335-1690461937.1757098335)

- [Howto](https://forum.manjaro.org/t/gnome-ibus-vs-vanilla-ibus/181338),
  [2](https://forum.endeavouros.com/t/gnome-ibus-vs-vanilla-ibus/74905),
  [3](https://discourse.gnome.org/t/gnome-ibus-vs-vanilla-ibus/31286)

### Kingst Logic Analyzers (LA1010, LA2016)

- Deploy [firmware extract scripts](https://sigrok.org/wiki/Firmware#Where_to_put_the_firmware_files), or **skip to PulseView installation if the firmware is already there** (`~/.local/share/sigrok-firmware`)

```
$ git clone git://sigrok.org/sigrok-util
$ cd sigrok-util/firmware/kingst-la
```

- [Download](http://www.qdkingst.com/en/vis-old) KingstVIS_v3.6.1.tar.gz to `sigrok-util/firmware/kingst-la`, then untar and extract

```
$ tar -zxf KingstVIS_v3.6.1.tar.gz
$ ./sigrok-fwextract-kingst-la2016 KingstVIS/KingstVIS
```

- Copy or move the firmware (`fw`, `bitstream` files) to `~/.local/share/sigrok-firmware`

Alternate good firmware (`sigrok-firmware.zip`) and LA1010 [info](https://www.foroelectro.net/herramientas-f27/analizadores-logicos-kingst-la-xxxx-y-sigrok-pulse-t474.html) for the unlucky (AppImage, Debian/Ubuntu)

- **Install PulseView**

```
$ yay -S pulseview-git
```

### Java

- Check and/or enable Java environment (as of 2024-11-01 should be something like `java-17-openjdk` for use with Flutter; less than 20)

```
$ archlinux-java
...
```

### Dart, Flutter, and Android

- In case of Android Studio, make sure _File > Settings > Appearance & Behavior > System Settings > Android SDK > SDK Tools > Android SDK Command Line Tools (latest)_ gets checked and installed;

- Otherwise, Android SDK Arch Linux way

```
yay -S android-platform android-sdk-cmdline-tools-latest android-sdk-build-tools android-sdk-platform-tools
```

```
sudo chown -R $USER:$USER /opt/android-sdk
```

- Android SDK without AUR

```
./sdk-install
```

- [flutterup](https://github.com/Decodetalkers/flutterup) and Flutter SDK manual installation

```
yay -S flutterup
```

without AUR

```
cargo install --locked --git https://github.com/Decodetalkers/flutterup
```

```
flutterup install
flutter doctor -v
```

- Flutter SDK location (flutterup default)

```
~/.local/share/flutterup
```

- Dart SDK location

```
~/.local/share/flutterup/bin/cache/dart-sdk
```

### Plasma

- Plasms 6, the panel icons won't stay pinned or unpinned (X11)

```
$ kquitapp6 plasmashell && plasmashell
```

- _Reboot!_

- In case of trouble with Gtk apps, reset Gtk settings to defaults

```
$ rm -rf ~/.config/gtk*
```

- Reboot

- [General purpose remedy](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks): reinstall everything

```
$ sudo pacman -Qqn | sudo pacman -S -
```

### SSD State

- If `smartmontools` package is installed

```
 sudo smartctl -a /dev/nvme0 [| grep Percentage]
```

### Hardware and system info

- General

```
ff
```

- Full info

```
fff
```

- Serial number

```
sudo dmidecode -t baseboard | grep "Serial Number"
```

### QEMU/KVM/Virtual Machine Manager

- [Default Netowrk](https://askubuntu.com/questions/1036297/cant-start-kvm-guest-network-default-is-not-active)

```
sudo virsh net-list --all
...
sudo virsh net-start default
```

### Optical Drive

- [USB Optical Drive](https://forum.endeavouros.com/t/usb-optical-drive/73276);
  wholly unnecessary (?), as it turned out :)

### Manage groups

- Review groups

```
bat /etc/group
```

- Check what groups the user belongs to

```
groups
```

- Create a group

```
sudo groupadd group
```

- Add user to a group

```
sudo usermod -aG group $USER
```

or

```
sudo gpasswd -a $USER group
```

- Remove user from group

```
sudo gpasswd --delete $USER group
```

### Downgrade all the files from executables recursively

- The [simplest way](https://superuser.com/questions/91935/how-to-recursively-chmod-all-directories-except-files)

```
chmod -R ugo-x,u+rwX,go+rX,go-w .
```

or

```
chmod -R u=rw,go=r,a+X .
```
