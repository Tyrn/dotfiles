#!/usr/bin/env bash

# shellcheck disable=SC1090
source ~/.gnome-kbd-lib.sh

if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
  exit 1
fi

if [ $# -eq 0 ]; then
  # No arguments; show the current layout.
  get_keyboard_layout_gnome
  exit 0
fi

if [ "$1" == "0" ]; then
  #  Zero first argument; show all the layouts.
  get_keyboard_layout_gnome "$1"
  exit 0
fi

set_keyboard_layout_gnome "$1"
