# Plasma KDE

## Theming

- [Use](https://github.com/tsujan/Kvantum/blob/master/Kvantum/INSTALL.md) Kvantum.
  It concerns itself only with applications, but is very thorough even by default.
  After installation check _KDE System Settings > Colors & Themes >
  Gloabl Theme/Colors/Application Style_.

  ```
  yay -S kvantum-qt6-git
  ```

  - Check/install the following configuration packages (Qt5/6 Settings):
    `qt5ct-kde` and `qt6ct-kde`
  - From _Global Theme_ select Breeze
  - With Qt5 Settings app set Breeze:KvBlender:XDG Desktop Portal
  - With Qt6 Settings app set Breeze:KvBlender:KDE
  - From _Colors_ select KvBlender
  - From _Application Style_ select qt6ct-style
  - You may need to log out/in more than once

## Troubleshooting

- Dialogs
  - Check `/etc/environment`. It should look like this:
    ```
    #QT_STYLE_OVERRIDE=kvantum
    #BROWSER=firefox
    #EDITOR=nano
    ...
    QT_QPA_PLATFORMTHEME=qt6ct
    ```
  - An example of `~/.config/xdg-desktop-portal/portals.conf`
    ```
    [preferred]
    default=gtk;kde;niri;hyprland
    org.freedesktop.impl.portal.FileChooser=kde
    ```
