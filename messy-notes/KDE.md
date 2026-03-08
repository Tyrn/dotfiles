# Plasma KDE

## Theming

- [Use](https://github.com/tsujan/Kvantum/blob/master/Kvantum/INSTALL.md) Kvantum.
  It concerns itself only with applications, but is very thorough even by default.
  After installation check _KDE System Settings > Colors & Themes >
  Colors/Application Style_.
  ```
  yay -S kvantum-qt6-git
  ```

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
  - GUI utilities _qt5ct_ and _qt6ct_ must be available.
    [Set](https://forum.endeavouros.com/t/file-choosers-on-qt-apps/78478/11)
    your preferences.
  - An example of `~/.config/xdg-desktop-portal/portals.conf`
    ```
    [preferred]
    default=gtk;kde;niri;hyprland
    org.freedesktop.impl.portal.FileChooser=kde
    ```
