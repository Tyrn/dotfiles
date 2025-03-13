# Manjaro Linux workstation config

For Plasma KDE and i3; also good for RPi. _X11 only_, so far!

- Create USB stick

  - Plug in, but do not mount the stick; check

  ```
  $ sudo fdisk -l
  ```

  - Upload the system

  ```
  $ sudo dd bs=4M if=linux.iso of=/dev/sda status=progress && sync
  ```

- Install Manjaro from USB stick

- Check session type

```
$ echo $XDG_SESSION_TYPE
x11
```

- Update the system

```
$ sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu
```

- Another take on update, to make it faster

```
$ sudo pacman-mirrors --geoip && sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu
```

- _Reboot_

- Install and bootstrap `chezmoi`

```
$ sudo pacman -S chezmoi
$ chezmoi init https://github.com/Tyrn/dotfiles.git
```

- Run the admin script. In case of success, **reboot** and jump right to **Check** and **Install the things**.
  In case of trouble, feel free to read the notes.

```
$ cd ~/.local/share/chezmoi/run-archlinux
$ [yes |] ./admin-add
```

- In case of _signature is unknown trust_, run

```
$ sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu
```

or

- General trust trouble, [1](https://forum.manjaro.org/t/update-error-failed-to-commit-transaction/150638),
  [2](https://forum.manjaro.org/t/error-failed-to-commit-transaction-invalid-or-corrupted-package-pgp-signature/150830)

```
$ sudo pacman-key --init
$ sudo pacman-key --populate archlinux manjaro
$ sudo pacman-key --refresh-keys           ;; This one takes a lot of time!
```

- Install [Chezmoi](https://www.chezmoi.io/):

```
$ sudo pacman -S chezmoi zoxide yay micro [nix]
```

- Init:

```
$ chezmoi init https://github.com/Tyrn/dotfiles.git
```

The repository is found in `~/.local/share/chezmoi`

- Deploy:

```
$ cp ~/.zshrc ~/.zshrc.old
$ chezmoi apply -v
```

- Set groups:

```
$ cd ~/.local/share/chezmoi/run-archlinux
run-archlinux $ ./groups-add
```

- Set udev rules:

```
run-archlinux $ ./udev-add
```

- _Reboot!_

- Add repositories (use `sudo micro /etc/pacman.conf`, Ctrl+C > Ctrl+Shift+V):

  - [archlinuxcn repo](https://wiki.archlinux.org/title/unofficial_user_repositories#archlinuxcn) (highly recommended)
  - [andontie-aur repo](https://wiki.archlinux.org/title/unofficial_user_repositories#andontie-aur) (highly recommended)

```
[archlinuxcn]
Server = http://repo.archlinuxcn.org/$arch
## or install archlinuxcn-mirrorlist-git and use the mirrorlist
#Include = /etc/pacman.d/archlinuxcn-mirrorlist

[andontie-aur]
Server = https://aur.andontie.net/$arch
```

- _archlinuxcn-keyring_ trouble: [archlinuxcn issue 3557](https://github.com/archlinuxcn/repo/issues/3557)

```
sudo pacman-key --lsign-key "farseerfc@archlinux.org"
```

- Update repositories:

```
$ yay -Syy
```

- **Check** `extras-install` (uncomment whatever you see fit).
  Don't forget to commit changes, or do `git reset --hard` later.

- **Install the things** `dotfiles` are all about:

```
run-archlinux $ yes | ./all-install
```

- Enable custom WM for KDE:

```
$ systemctl mask --user plasma-kwin_x11
$ systemctl enable --user plasma-custom-wm.service
```

- Back to KWin:

```
$ systemctl unmask --user plasma-kwin_x11
$ systemctl disable --user plasma-custom-wm.service
```

_NB_ No symlinks so far

## Fedora

- Get fedora-dotfiles

```
curl -OL "https://github.com/Tyrn/dotfiles/raw/main/run-fedora/fedora-dotfiles.sh"
bash fedora-dotfiles.sh
```

- TODO...

- After successfully moving to _zsh_, and before running any app,

```
chezmoi apply --force
```

### Important extensions

- [PaperWM](https://github.com/paperwm/PaperWM),
  [e.g.org](https://extensions.gnome.org/extension/6099/paperwm/)

- [Switcher](https://github.com/daniellandau/switcher),
  [e.g.org](https://extensions.gnome.org/extension/973/switcher/)

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

- Mise

  - List all packages

  ```
  mise ls -g
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

- [**Assorted notes**](https://github.com/Tyrn/arch-chronicle/tree/master/Usage)

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
$ pkill -KILL -u $USER
```

- Make GRUB menu visible

```
$ sudo micro /etc/default/grub
```

Change timeout style(`/etc/default/grub`):

```
GRUB_TIMEOUT_STYLE=menu
```

Update GRUB:

```
$ sudo update-grub
```

- Install [fzf](https://github.com/junegunn/fzf#using-git) if necessary, using git; to `Do you want to update your shell config...` say no

```
$ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$ ~/.fzf/install
```

- [Vim spell checking files (.spl, .sug)](https://ftp.nluug.nl/vim/runtime/spell/)

- (Re)install AstroNvim

```
~/.local/share/chezmoi/run-archlinux/nvim-reinstall
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

- Say `yes` once asked _Are you sure..._ (the question is never repeated):

```
$ git clone git@github.com: ...
Cloning into ...
The authenticity of host '...' can't be established.
...
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
```

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
$ yay -S android-platform android-sdk-cmdline-tools-latest android-sdk-build-tools android-sdk-platform-tools
$ sudo chown -R $USER:$USER /opt/android-sdk
```

- [flutterup](https://github.com/Decodetalkers/flutterup) and Flutter SDK manual installation

```
$ yay -S flutterup
$ flutterup install
$ flutter doctor -v
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

### QEMU/KVM/Virtual Machine Manager

- [Default Netowrk](https://askubuntu.com/questions/1036297/cant-start-kvm-guest-network-default-is-not-active)

```
sudo virsh net-list --all
...
sudo virsh net-start default
```

### Downgrade all the files from executables recursively

- The [simplest way](https://superuser.com/questions/91935/how-to-recursively-chmod-all-directories-except-files)

```
chmod -R u+rwX,go+rX,go-w .
```
