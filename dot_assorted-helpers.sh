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

# Zip a git project leaving out the .git directory.
# Usage:
# shallow-git-zip /path/to/project output.zip
function shallow-git-zip() {
  local project_dir="$1"
  local zip_file="$2"

  cd "$project_dir" || return

  #echo "Creating zip from tracked files (excluding .venv, dist, build, node_modules, lock files)..."

  git ls-files |
    grep -v '^\.venv/' |
    grep -v '^dist/' |
    grep -v '^build/' |
    grep -v '^node_modules/' |
    grep -v '^\.next/' |
    grep -v '^coverage/' |
    grep -v '^__pycache__/' |
    grep -v '\.lock$' |
    grep -v '\.log$' |
    zip -r "$zip_file" -@

  #echo "Created: $zip_file"
  #unzip -l "$zip_file" | head -20

  cd - >/dev/null || return
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

# Check emoji rendering
function moji() {
  local n=12
  printf "%*s" "$n" ""
  echo "\U1f344 \U1f600 \U1f34a \u2728 \U1f340 \U0001f337 \U1fabb \U1f981 \U1f4A1 \U1f341 \u2764  \u2b50"
  printf "%*s" "$n" ""
  echo "\U1f33d \U1f33e \U1f490 \U1f940 \U1f342 \U1f982 \U1f98b \U1f41e \U1f3f0 \U1f49b \U1f3b2 \U1f352"
}

# Install cabal app locally
function cabal-i() {
  cabal install --installdir="$HOME"/.local/bin --overwrite-policy=always
}

# Build and install cabal app locally
function cabal-bi() {
  cabal build && cabal-i
}

alias dm=damastes
alias dh=dahastes
alias dp=procrustes
alias lls="ls -lha --color=always | less -r"
alias lss="ls --color=always | less -r"
alias exstat="expac -H M '%m\t%n' | sort -h"
alias exst="exstat | tail -n 10"
alias lg="lazygit"
alias nv="neovide"
alias dozer="docker-compose run buildozer android"
alias get_idf='. $HOME/esp/esp-idf/export.sh'
alias ff="fastfetch"
alias fff="fastfetch -c all.jsonc"
alias ac="printf '%s\n' ~/.arduino15/packages/*/hard*/*/*"
alias acl="arduino-cli"
#alias nt='alacritty --working-directory "$PWD" &'
#alias nt='alacritty --working-directory "$(pwd -P)" &'  # Good for symlinks.
#alias nt='alacritty -e zsh -c "cd \"$PWD\" && zsh" &'
#alias nt='nohup alacritty --working-directory "$PWD" >/dev/null 2>&1 & disown'
#alias nt='setsid alacritty --working-directory "$PWD" --config-file /dev/null >/dev/null 2>&1'
alias nt='setsid alacritty --working-directory "$PWD" >/dev/null 2>&1'

function pipver-col() { curl -s "https://pypi.org/rss/project/$1/releases.xml" | sed -n 's/\s*<title>\([^<]*\).*/\1/p'; }
function pipver() { curl -s "https://pypi.org/rss/project/$1/releases.xml" | sed -n 's/\s*<title>\([^<]*\).*/ \1/p' | paste -sd,; }
function tpipver() { curl -s "https://test.pypi.org/rss/project/$1/releases.xml" | sed -n 's/\s*<title>\([^<]*\).*/ \1/p' | paste -sd,; }

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
  printf '%s\n' */ >_pkglist.txt
  #ls -d */ | sed 's|/$|/|' >_pkglist.txt
  aur build -a ./_pkglist.txt -d "$database" --margs -s
}
