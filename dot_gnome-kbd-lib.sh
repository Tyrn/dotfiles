function get_keyboard_layout_gnome() {
  local get_properties=(gdbus introspect --session
    --dest org.gnome.Shell
    --object-path /me/madhead/Shyriiwook
    --only-properties)

  if [ ! $# -eq 0 ]; then
    # Some argument passed; watch the whole hog:
    "${get_properties[@]}"
    return 0
  fi
  local current_layout=("$(
    "${get_properties[@]}" |
      python3 -c "
import sys
import re
lines = sys.stdin.readlines()
for line in lines:
    if 'readonly' in line and 'currentLayout' in line:
        match = re.search(r\"= '([^']+)'\", line)
        if match:
            print(match.group(1))
        break
"
  )")
  printf "%s\n" "${current_layout[0]}"
}

function set_keyboard_layout_gnome() {
  local id=$1 # Gets ignored, if incorrect.

  gdbus call --session \
    --dest org.gnome.Shell \
    --object-path /me/madhead/Shyriiwook \
    --method me.madhead.Shyriiwook.activate \
    "${id}"
}
