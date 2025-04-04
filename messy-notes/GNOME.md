# GNOME 47 and upwards

- Settings entry points

  - _Settings_; basic Gnome settings ⚙

  - _Extensions_ 🧩

    - [PaperWM](https://github.com/paperwm/PaperWM),
      [e.g.org](https://extensions.gnome.org/extension/6099/paperwm/)

    - [Dash to Dock](https://github.com/micheleg/dash-to-dock)

    - [Switcher](https://github.com/daniellandau/switcher),
      [e.g.org](https://extensions.gnome.org/extension/973/switcher/)

    - [AppIndicator and KStatusNotifierItem Support](https://github.com/ubuntu/gnome-shell-extension-appindicator),
      [e.g.org](https://extensions.gnome.org/extension/615/appindicator-support/)

  - _Tweaks_; additional Gnome settings

  - _dconf Editor_; universal settings GUI, same as CLI
    [gsettings](https://discourse.gnome.org/t/what-is-the-purpose-of-gsettings/17165)

- Low level key remapping with [keyd](https://github.com/rvaiya/keyd)

  - `/etc/keyd/default.conf` suggestion, if the keyboard absolutely lacks essential keys
    to the right; less drastic default solution,
    [kbd-tune](/kbd-tune)

  ```
  [ids]
  *

  [main]
  kp0 = rightcontrol
  kpdot = compose
  rightcontrol = layer(meta)
  capslock = layer(nav)

  [nav]
  h = left
  k = up
  j = down
  l = right
  р = left
  л = up
  о = down
  д = right
  ```

  - After editing, restart

  ```
  sudo systemctl restart keyd
  ```

  - Check syntax errors

  ```
  systemctl status keyd
  ```

  - Turn off remapping

  ```
  sudo systemctl [stop|disable] keyd
  ```

  - Monitor key pressing in real time

  ```
  sudo keyd -m
  ```

- Redefine lock screen shortcut _Settings > Keyboard > View
  and Customize Shortcuts > System > Lock screen_ (to Ctrl+Delete)

- Create custom shortcut _Settings > Keyboard > View
  and Customize Shortcuts_ Launch Terminal (Alt+Return)

- _Settings > Mouse & Touchpad > Scroll Direction_: Traditional/Natural

- An app (Google Chrome) sometimes starts unfocused (in the scratch layer).
  To make it normal, press Ctrl+Super+Esc.

- Desktop scale

  - _Tweaks > Fonts > Scaling Factor_

  - _Settings_..?

- Dolphin not serving
  [_Open With_](https://www.reddit.com/r/kde/comments/1jj1ziw/dolphin_and_open_with/)

  - Download the config

  ```
  curl -L https://raw.githubusercontent.com/KDE/plasma-workspace/master/menu/desktop/plasma-applications.menu -o $HOME/.config/menus/applications.menu
  ```

  - Use `kservice` to rebuild the KDE cache. Implemented in
    [kde-to-gnome](/kde-to-gnome)

  ```
  kbuildsycoca6 --noincremental
  ```
