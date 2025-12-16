# GNOME 47 and upwards

- Weird naming
  - _Loupe_ app is referred to as _Image Viewer_
  - _Nautilus_ is referred to as _Files_
  - _Evince_ (_Papers_, too) is referred to as _Document Viewer_

- Settings entry points
  - _Settings_; basic Gnome settings ⚙

  - _Extensions_ 🧩
    - [**Shyriiwook**](https://github.com/madhead/shyriiwook),
      [e.g.org](https://extensions.gnome.org/extension/6691/shyriiwook);
      _Required for Neovim advanced keyboard management!_

    - [PaperWM](https://github.com/paperwm/PaperWM),
      [e.g.org](https://extensions.gnome.org/extension/6099/paperwm/)

    - System Monitor,
      [e.g.org](https://extensions.gnome.org/extension/6807/system-monitor/)

    - [Dash to Dock](https://github.com/micheleg/dash-to-dock)

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
