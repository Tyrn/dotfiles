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

- After `chezmoi apply -v`:
  - `cd ~/.config/niri`
  - At the end of `config.kdl`, add
    ```
    include "user/common.kdl"
    ```
  - Comment out (`/-`) `input ...` clause in `config.kdl`
  - Comment out (`/-`) `Mod+Space ...`
    clause in `dms/binds.kdl`

## Notes

_2026-11-07_: As the correct starting of `neovide` in `niri` turned out
to be very troublesome, here's the snippet of the original
_almost_ correct code (nv() and nvv())

```
if command -v alacritty >/dev/null 2>&1; then
  function na() {
    setsid alacritty --working-directory "$PWD" >/dev/null 2>&1
  }

  if [[ "$XDG_CURRENT_DESKTOP" == "niri" ]]; then
    function nd() {
      (na &)
      sleep 0.3
      niri msg action consume-or-expel-window-left
      niri msg action set-column-display tabbed
    }
    function nf() {
      (na &)
      sleep 0.3
      niri msg action consume-or-expel-window-left
      niri msg action focus-window-up
      niri msg action set-column-display tabbed
    }
    function nff() {
      (na &)
      sleep 0.3
      niri msg action consume-or-expel-window-left
      niri msg action set-column-display tabbed
      (na &)
      sleep 0.3
      niri msg action consume-or-expel-window-left
      niri msg action focus-window-up
      niri msg action focus-window-up
    }
    function nv() {
      (nv-start "$@" &)
      nv-sleep
      niri msg action consume-or-expel-window-left
      niri msg action move-window-up
      niri msg action set-column-display tabbed
    }
    function nvv() {
      (nv-start "$@" &)
      nv-sleep
      niri msg action consume-or-expel-window-left
      niri msg action move-window-up
      niri msg action set-column-display tabbed
      (na &)
      sleep 0.3
      niri msg action consume-or-expel-window-left
      niri msg action focus-window-up
      niri msg action focus-window-up
    }
    function nv-start() {
      setsid neovide --no-multigrid "$@" >/dev/null 2>&1
    }
    function nv-sleep() {
      local tries=0
      #until niri msg --json windows | grep -q '"app_id":"neovide"'; do
      until niri msg --json windows | jq -e 'any(.[]; .app_id == "neovide")' >/dev/null 2>&1; do
        sleep 0.1
        ((tries++ > 20)) && break
      done
    }
  fi
fi
```
