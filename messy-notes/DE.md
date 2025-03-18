## Desktop Environments
### LXDE

- `/etc/xdg/lxsession/LXDE/autostart`:
```
@lxpanel --profile LXDE
@pcmanfm --desktop --profile lxde
@xscreensaver -no-splash
@xinput --set-prop --type=int --format=8  "SynPS/2 Synaptics TouchPad" "Synaptics Edge Scrolling" 1 0 0
@setxkbmap -model evdev -layout us,ru -variant , -option -option grp:caps_toggle
@gkrellm
@qstardict
```

- `~/.config/lxpanel/LXDE/panels`

- `~/.config/openbox/lxde-rc.xml`

- `~/.config/lxsession/LXDE/desktop.conf`:
```
[Session]
window_manager=compiz ccp --indirect-rendering
OR window_manager=openbox-lxde
```

- No KDM entry: just copy `/usr/share/xsessions/LXDE.desktop` to `/usr/share/apps/kdm/sessions/LXDE.desktop`

##### Places where `*.desktop` files live:

- `/usr/share/applications`
- `~/.local/share/applications`
- `/usr/local/share/applications`

##### Keyboard Layout (.bashrc):
```
setxkbmap -option grp:switch,grp:caps_toggle,grp_led:scroll us,ru
```
- The above messes with the Alt key, grp:switch removed:
```
setxkbmap -option grp:caps_toggle,grp_led:scroll us,ru
```

### Fluxbox
```
$ sudo pacman -S feh network-manager-applet alltray
```
- From AUR: `fluxmod-styles` `fbxkb`

- `~/.fluxbox/startup`:
```
...
# Adjust TouchPad:
xinput --set-prop --type=int --format=8  "SynPS/2 Synaptics TouchPad" "Synaptics Edge Scrolling" 1 1 0       #     vertical, horizontal, corner - values: 0=disable  1=enable

# Set keyboard layout:
# setxkbmap -option grp:caps_toggle,grp_led:scroll us,ru

...
idesk &
exec fbsetbg /home/alexey/common/System/Appearance/Wallpapers/sant_angelo_bridge-1400x1050.jpg &
# exec fbxkb &
# exec /opt/dropbox/dropboxd &
# exec /usr/bin/dropbox &
exec /home/alexey/.dropbox-dist/dropboxd &
exec nm-applet &
exec gkrellm -g +1287+0 &
# exec xscreensaver -no-splash &
exec gis-weather &
exec volumeicon &

export GTK_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"
export QT_IM_MODULE="ibus"
exec ibus-daemon -drx &
exec fluxbox
...
```
- `~/.fluxbox/apps`:
```
...
[group]
  [app] (name=xterm) (class=XTerm)
[end]
[group]
  [app] (name=geany) (class=Geany)
[end]
```
- `~/.fluxbox/init`:
```
...
session.screen0.toolbar.tools:	RootMenu, prevworkspace, workspacename, nextworkspace, iconbar, systemtray, clock
session.screen0.strftimeFormat: %F %a %k:%M
```

- System styles (`~/.fluxbox/init` (`session:styleFile`)): `Panbox` (very light), `Megatron-red2` (dark red)

### Xinit
[Archwiki](https://wiki.archlinux.org/index.php/Xinit)

Backing from Nvidia (to Intel Graphics):
```
$ yaourt -R nvidia-340xx-utils
$ glxinfo
```
##### Bypassing Display Manager:

- Disable SDDM:
```
$ sudo systemctl disable sddm
```
- Create  `.xinitrc` (default):
```
$ cp /etc/X11/xinit/xinitrc ~/.xinitrc
```
- Edit  `.xinitrc`:
```
...
#~ twm &
#~ xclock -geometry 50x50-1+1 &
#~ xterm -geometry 80x50+494+51 &
#~ xterm -geometry 80x20+494-0 &
#~ exec xterm -geometry 80x66+0+0 -name login

#~ exec startfluxbox
exec startkde
```
- Run DE:
```
$ startx
```

### KDE

#### KWallet, [discussion](https://forum.manjaro.org/t/i3-alongside-kde-no-wi-fi-no-mail-accounts-for-google-chrome-kwallet-problem/130570)

- Remove KWallet, if necessary (forgotten password, etc.):
```
$ rm .local/share/kwalletd/kdewallet.kwl
```
- Google Chrome config, [ArchWiki](https://wiki.archlinux.org/title/KDE_Wallet#KDE_Wallet_for_Chrome_and_Chromium):
```
$ cat .config/chrome-flags.conf
--password-store=kwallet5
```

#### i3 Network Manager

- [nmcli](https://jaketrent.com/post/network-manager-terminal-i3/) is part of `networkmanager`:
```
$ yay -F nmcli
extra/networkmanager 1.40.8-1 [installed]
    usr/bin/nmcli
    usr/share/bash-completion/completions/nmcli
```

#### i3 window manager, [ArchWiki](https://wiki.archlinux.org/title/I3)

- Manage dialog windows (X11 only?), `~/.config/i3/config`
```
for_window [window_role="dialog"] floating enable
```
- `$ yay -S i3-gaps dmenu[-manjaro] i3status` (moved to dotfiles)
- `~/.config/plasma-workspace/env/set_window_manager.sh` (Obsolete):
```
export KDEWM=/usr/bin/i3
```
- Create i3 service, `~/.config/systemd/user/plasma-custom-wm.service` (moved to dotfiles):
```
[Install]
WantedBy=plasma-workspace.target

[Unit]
Description=Plasma Custom Window Manager
Before=plasma-workspace.target

[Service]
ExecStart=/usr/bin/i3
Slice=session.slice
Restart=on-failure
```
- Check the running KWin, mask it, enable i3, and reboot:
```
ᐅ systemctl status --user plasma-kwin_x11
...
ᐅ systemctl mask --user plasma-kwin_x11
ᐅ systemctl enable --user plasma-custom-wm.service
```
- On `i3lock` use: [issue #119](https://github.com/i3/i3lock/issues/119), [Better approach to lock, shutdown, etc.](https://wiki.archlinux.org/title/i3#Shutdown.2C_reboot.2C_lock_screen)

- `~/.config/plasma-localerc`, default:
```
[Formats]
LANG=en_US.UTF-8
```
