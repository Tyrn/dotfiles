# GNOME 47 and upwards

- Low level key remapping with [keyd](https://github.com/rvaiya/keyd)

  - Config example, `/etc/keyd/default.conf`

  ```
  [ids]
  *

  [main]
  compose = layer(meta)
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

- Check Extensions app 🧩

- Settings > Mouse & Touchpad > Scroll Direction: Traditional/Natural

- An app (Google Chrome) sometimes starts unfocused (in the scratch layer).
  To make it normal, press Ctrl+Super+Esc.
