# shuck: disable-file=C001,C006,C018,C043,C063,C124,C150,C155

if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
  alias nv="neovide"
fi

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
    function nv-start() {
      setsid neovide --no-multigrid "$@" >/dev/null 2>&1
    }
    function nv() {
      # Capture the terminal that will receive Neovide, before it opens.
      local terminal_id
      terminal_id=$(niri msg --json focused-window | jq -r '.id')

      # Start an event-stream listener that captures the first Neovide window opening.
      local select_nv='select(.WindowOpenedOrChanged.window.app_id == "neovide") | .WindowOpenedOrChanged.window'
      local event_file
      event_file=$(mktemp)
      (niri msg --json event-stream |
        jq -c --unbuffered "$select_nv" >"$event_file") 2>/dev/null &|
      local listener_pid=$!

      # Launch Neovide detached.
      (nv-start "$@" &)

      # Wait for the event file to have content (max 2 seconds).
      local tries=0
      while [[ ! -s "$event_file" ]]; do
        sleep 0.1
        ((tries++ > 20)) && break
      done

      # Stop the listener and read the captured window.
      kill "$listener_pid" 2>/dev/null
      local neovide_id
      neovide_id=$(head -n1 "$event_file" | jq -r '.id')
      rm -f "$event_file"

      if [[ -z "$neovide_id" || "$neovide_id" == "null" ]]; then
        echo "nv: Neovide window did not appear" >&2
        return 1
      fi

      # Get the column indices of the terminal and Neovide.
      # shellcheck disable=SC2016
      local selid='.[] | select(.id == $id) | .layout.pos_in_scrolling_layout[0]'
      local terminal_col neovide_col
      terminal_col=$(niri msg --json windows | jq -r --argjson id "$terminal_id" "$selid")
      neovide_col=$(niri msg --json windows | jq -r --argjson id "$neovide_id" "$selid")

      # If Neovide is not immediately to the right of the terminal, move its column there.
      if [[ -n "$terminal_col" && -n "$neovide_col" && "$neovide_col" -gt $((terminal_col + 1)) ]]; then
        niri msg action focus-window --id "$neovide_id"
        niri msg action move-column-to-index $((terminal_col + 1))
      fi

      # Focus the terminal, consume the right neighbor (now Neovide),
      # then focus Neovide and move it to the top of the tabbed column.
      niri msg action focus-window --id "$terminal_id"
      niri msg action consume-window-into-column
      niri msg action focus-window --id "$neovide_id"
      niri msg action move-window-up
      niri msg action set-column-display tabbed
    }
    function nvv() {
      nv "$@"

      # Open a second terminal in the same column, and tab it.
      (na &)
      sleep 0.3
      niri msg action consume-or-expel-window-left
      niri msg action focus-window-up
      niri msg action focus-window-up
      niri msg action set-column-display tabbed
    }
  fi
fi
