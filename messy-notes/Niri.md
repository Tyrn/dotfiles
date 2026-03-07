# Niri Wayland compositor

## Troubleshooting

- Just in case: `~/.config/systemd/user/graphical-session.target.wants/dms.service`
  _must not exist!_ Unless you want DMS to start on _any_ desktop, like KDE,
  for instance.

## How to

- Learn about the opened windows

```
niri msg windows
```

## Settings

_Almost everything implemented via_ `common.kdl`

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
