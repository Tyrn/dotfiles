# GNOME 47 and upwards

- Low level key remapping with [keyd](https://github.com/rvaiya/keyd)

  - Config example, `/etc/keyd/default.conf`

  ```
  [ids]
  *

  [main]
  kp0 = rightcontrol
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

- Check Extensions app 🧩

- _Settings > Mouse & Touchpad > Scroll Direction_: Traditional/Natural

- An app (Google Chrome) sometimes starts unfocused (in the scratch layer).
  To make it normal, press Ctrl+Super+Esc.
