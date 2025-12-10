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

- Keyboard, mouse and touchpad, 2025-12-10 `~/.config/niri/config.kdl`

```
input {
    keyboard {
        xkb {
        }
        //numlock
    }
    touchpad {
        tap
    }
    mouse {
    }
    trackpoint {
    }
}
```

- _Don't forget about the monitor settings!_ (`output`)
