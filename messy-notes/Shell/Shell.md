## Linux Shell
### Bash

#### chmod

Remove executable bit recursively from files (not directories)

`$ chmod -R -x+X *`

`-R` - operate recursively
`-x` - remove executable flags for all users
`+X` - set executable flags for all users if it is a directory

#### Color prompt

end of `~/.bashrc`:

`PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '`

#### find

`$ find . -type f -name "*.rar" -exec unrar x {} \;`

### Groups

```
$ sudo groupadd <group>
$ sudo gpasswd -a $USER <group>
```
[or](https://askubuntu.com/questions/1366061/when-gpasswd-vs-usermod-deluser)
```
$ sudo usermod -aG <group> $USER
```
#### Useful groups easily fortotten
- *uucp*: user acces to serial ports (*dialout* for Debian/Ubuntu)
- *vboxsf*: user access to VirtualBox shared folders
- *docker*
- *input*
- *sdkusers*: user access to SDKs installed in `/opt`

### Utilities
#### autojump
`~/.bashrc`:
```
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh


# autojump: Arch Wiki, https://github.com/wting/autojump; Tilix: https://gnunn1.github.io/tilix-web/manual/vteconfig/
#
. /etc/profile.d/vte.sh
. /etc/profile.d/autojump.bash

```
#### sha256sum
```
$ echo <sum> <filename> | sha256sum -c -
```

#### ffmpeg

- For a single file:
```
$ ffmpeg -i <infile.m4b> -acodec libmp3lame -ar 22050 <outfile.mp3>
```
- For a bunch of M4B files:
```
$ for m4b in $(ls -1 *.m4b); do ffmpeg -i $m4b -acodec libmp3lame -ar 22050 ${m4b}.mp3; done
```
- Better still:
```
$ for m4b in *.m4b; do ffmpeg -i "$m4b" -acodec libmp3lame -ar 22050 "${m4b%.*}.mp3"; done
```
- Bitrate control (something's wrong with -ab 32; gets substituted with 64):
```
$ for m4b in *.m4b; do ffmpeg -i "$m4b" -acodec libmp3lame -ar 22050 -ab 32 "${m4b%.*}.mp3"; done

$ for wma in *.wma; do ffmpeg -i "$wma" -acodec libmp3lame -ab 128k "${wma%.*}.mp3"; done
```

- wmv to mp4 320x240:
```
$ for wmv in *.wmv; do ffmpeg -i "$wmv" -s qvga "${wmv%.*}.mp4"; done
```

#### imagemagick
- pdf -> pdf conversion/compression;
`-density` 100 seems optimal, loss of quality is visible;
less density, more compression;
sharpening does not make it much better
```
$ convert -compress jpeg -density 100 alfa.pdf alfa-c.pdf
$ convert -compress jpeg -density 50 alfa.pdf alfa-cc.pdf
$ convert -compress jpeg -density 200 alfa.pdf alfa-ccc.pdf
$ convert -compress jpeg -density 100 -sharpen 0x3 alfa.pdf alfa-cccc.pdf
```
- resize
```
$ convert 2.jpg -resize 150x150 3.jpg
```
- append
```
$ convert image1.png image2.png image3.png -append result/result-sprite.png
```

#### makepkg

`yaourt` example:
```
$ sudo pacman -Rsn package-query yaourt

$ wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
$ tar xfz package-query.tar.gz 
$ cd package-query && makepkg
$ sudo pacman -U package-query*.pkg.tar.xz

$ wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
$ tar xzf yaourt.tar.gz
$ cd yaourt && makepkg
$ sudo pacman -U yaourt*.pkg.tar.xz
```

#### mp3splt
```
$ mp3splt -f -t 10.00 -a *.mp3 -o @f-@n
$ mp3splt -f -t 10.00 -a *.mp3 -o @n-@f
```

#### ping

Problem:
```
$ ping -c 3 www.google.ru
ping: icmp open socket: Operation not permitted
```
Solution:
```
$ ls -l /bin/ping 
lrwxrwxrwx 1 root root 13 Jun 19 00:24 /bin/ping -> /usr/bin/ping 
$ ls -l /usr/bin/ping 
-rwxr-xr-x 1 root root 34788 Jun 19 00:24 /usr/bin/ping 
$ sudo chmod u+s /usr/bin/ping
$ ls -l /usr/bin/ping
-rwsr-xr-x 1 root root 34788 Jun 19 00:24 /usr/bin/ping
```

#### sudo

##### kdesu

`~/.kde4/share/config/kdesurc`, `~/.config/kdesurc` (create if necessary):
```
[super-user-command]
super-user-command=sudo
```
`/etc/sudoers`:
```
root ALL=(ALL) ALL
%wheel ALL=(ALL) ALL

## Same thing without a password
# %wheel ALL=(ALL) NOPASSWD: ALL

## Uncomment to allow members of group sudo to execute any command
# %sudo	ALL=(ALL) ALL

%alexey ALL=NOPASSWD: /usr/bin/pacman
%alexey ALL=NOPASSWD: /usr/bin/pacdiffviewer
%alexey ALL=NOPASSWD: /usr/bin/yay

## #includedir /etc/sudoers.d
```

#### rfkill
```
$ rfkill list all
0: phy0: Wireless LAN
        Soft blocked: yes
        Hard blocked: no

$ sudo rfkill unblock 0
$ rfkill list all
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
```

##### Wiki: NetworkManager

- Hardware switch Off, Enable Wireless grayed out :
```
$ rfkill list all
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: yes
```
- Hardware swith On:
```
$ rfkill list all
0: phy0: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
```
- Hardware switch On and Enable Wireless checked:
```
$ rfkill list all
0: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
```
