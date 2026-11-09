kit="$HOME/.zkit"

# A very special case of IBus (scripted switch).
if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
  source "$kit"/gnome-kbd-lib.sh
fi

# Script to make alacritty and neovide
# manageable
source "$kit"/tiling-kludges.zsh

# Odds and ends in one place.
source "$kit"/assorted-helpers.zsh
