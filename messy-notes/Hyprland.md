# Hyprland desktop

## [ML4W](https://github.com/mylinuxforwork/dotfiles)

### Bare minimum changes

- `~/.config/hypr/conf/keybindings/default.conf`:

```
# Move focus horizontally, alternate take
bind = $mainMod, H, movefocus, l # Move focus left
bind = $mainMod, L, movefocus, r # Move focus right

# Move between grouped windows
bind = $mainMod CTRL , H, changegroupactive, b
bind = $mainMod CTRL , L, changegroupactive, f
```

- `~/.config/hypr/conf/keyboard.conf`:

```
input {
    kb_layout = us,ru
    ...
    kb_options = altwin:swap_alt_win,grp:shifts_toggle
    ...
}
```

- `~/.config/ml4w/settings/terminal.sh`:

```
alacritty
```

- `~/.config/qt6ct/qt6ct.conf`:

```
...
custom_palette=false
...
```
