# Niri Wayland compositor

## Theming and dialogs

- [Plasma KDE](/messy-notes/KDE.md)

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

- After `chezmpi apply -v`:
  - `cd ~/.config/niri`
  - At the end of `config.kdl`, add
    ```
    include "user/common.kdl"
    ```
  - Comment out (`/-`) `input ...` clause in `config.kdl`
  - Comment out (`/-`) `Mod+Space ...`
    clause in `dms/binds.kdl`
