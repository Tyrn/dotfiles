# Niri Wayland compositor

## Settings

- For IBus, add to `~/.config/niri/config.kdl`

```
spawn-at-startup "ibus" "start" "--type" "wayland"
```

in case of a hotkey conflict, change in `binds`:

```
Mod+Space
```

to

```
Ctrl+Space
```
