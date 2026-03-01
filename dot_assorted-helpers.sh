# Some environment variables, aliases, etc.
# To be included in ~/.zshrc

export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"

#export CODE=~/spaces

export SAM_CLI_TELEMETRY=0

# A list of file extensions,
# encountered recursively.
function lsext-col() {
  local dir="${1:-.}"
  find "$dir" -type f | grep -E '\.[^./][^./]*$' | sed 's/.*\.//' | sort -u
}

function lsext() {
  local dir="${1:-.}"
  find "$dir" -type f | grep -E '\.[^./][^./]*$' | sed 's/.*\.//' | sort -u | paste -sd ' '
}

# Remove exec permission recursively.
function chmod-x() {
  local dir="${1:-.}"
  chmod -R u=rw,go=r,a+X "$dir"
}

# Recursive/selective copying;
# only the specified extensions included.
function cprf() {
  if [[ $# -lt 3 ]]; then
    echo "Usage: cprf source dest ext1 [ext2 ...]"
    return 1
  fi

  local src="$1"
  local dest="$2"
  shift 2

  # Build include args
  local include_args="--include=\"*/\""
  for ext in "$@"; do
    include_args="$include_args --include=\"*.$ext\""
  done

  # Execute
  eval "rsync -avm $include_args --exclude=\"*\" \"$src/\" \"$dest/\""
}

function scc() {
  # Clean download cache if anything exists (glob with N for null_glob)
  sudo rm -rf /var/cache/pacman/pkg/download*(DN) 2>/dev/null
  yes | yay -Scc
}

alias dm=damastes
alias dp=procrustes
alias lls="ls -lha --color=always | less -r"
alias lss="ls --color=always | less -r"
alias exstat="expac -H M '%m\t%n' | sort -h"
alias exst="exstat | tail -n 10"
alias lg="lazygit"
alias dozer="docker-compose run buildozer android"
alias get_idf='. $HOME/esp/esp-idf/export.sh'
alias ff="fastfetch"
alias fff="fastfetch -c all.jsonc"
alias ac="printf '%s\n' ~/.arduino15/packages/*/hard*/*/*"
alias acl="arduino-cli"
if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
  alias nv="neovide"
else
  function nv() {
    # Launch Neovide in the background, disown it from the shell, and pass the current directory
    neovide --no-multigrid --fork "$@"
    # Wait a tiny moment for the window to appear, then close the terminal
    sleep 0.5 && exit
  }
fi
#alias nt='alacritty --working-directory "$PWD" &'
#alias nt='alacritty --working-directory "$(pwd -P)" &'  # Good for symlinks.
#alias nt='alacritty -e zsh -c "cd \"$PWD\" && zsh" &'
#alias nt='nohup alacritty --working-directory "$PWD" >/dev/null 2>&1 & disown'
#alias nt='setsid alacritty --working-directory "$PWD" --config-file /dev/null >/dev/null 2>&1'
alias nt='setsid alacritty --working-directory "$PWD" >/dev/null 2>&1'

function cf() { clang-format -i **/*.{c,cpp,h,hh,hpp,ino,cc,hxx}; }

function pipver-col() { curl -s https://pypi.org/rss/project/$1/releases.xml | sed -n 's/\s*<title>\([^<]*\).*/\1/p'; }
function pipver() { curl -s https://pypi.org/rss/project/$1/releases.xml | sed -n 's/\s*<title>\([^<]*\).*/ \1/p' | paste -sd,; }
function tpipver() { curl -s https://test.pypi.org/rss/project/$1/releases.xml | sed -n 's/\s*<title>\([^<]*\).*/ \1/p' | paste -sd,; }

# Fetches into the (empty) current directory a [package] from AUR,
# along with its AUR dependencies, if any, builds it/them
# and puts the package[s] into the [database] repository.
# The local [database] repository must exist.
# NB If [package] is 0, no fetching from AUR is performed.
function to-repo() {
  local package="${1}"
  local database="${2:-sandbox}" # Use 'sandbox' as default.

  if [[ -z "$package" ]]; then
    echo "Usage: to-repo <aur-package>|0 [database]"
    echo "Default database: sandbox"
    return 1
  fi

  if [[ "$package" != "0" ]]; then
    aur fetch -r "$package"
  fi
  ls -d */ | sed 's|/$|/|' >_pkglist.txt
  aur build -a ./_pkglist.txt -d "$database" --margs -s
}
