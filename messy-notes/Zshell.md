## Zshell

### Remove exec permissions from all the [ordinary files](https://unix.stackexchange.com/questions/296967/how-to-recursively-remove-execute-permissions-from-files-without-touching-folder)

```
chmod a-x asvetliakov.vscode-neovim-1.6.0-universal/**/*(D.)
```

### Install

```
$ yay -S oh-my-zsh[-git]
$ chsh -s $(which zsh)
$ ps -p $$
$ echo $SHELL
```

- Troubleshooting: [Extra shells](https://unix.stackexchange.com/questions/39881/running-chsh-does-not-change-shell)

```
$ who
danny  pts/0        Nov 6 13:53 (10.1.6.121)
danny  pts/1        Nov 5 12:30 (10.1.6.165)
danny  pts/2        Nov 4 12:33 (10.1.6.197)
$ pkill -KILL -u danny
```

- Required:

```
$ yay -S zoxide
$ yay -S python-virtualenvwrapper
```

- Extras: [Rust utilities](https://deepu.tech/rust-terminal-tools-linux-mac-windows-fish-zsh/)

```
$ yay -S noto-color-emoji-fontconfig
$ yay -S alacritty
$ yay -S alacritty-themes
```

`~/.xprofile`:

```
export TERMINAL=/usr/bin/alacritty

#export PATH=/usr/local/texlive/2018/bin/x86_64-linux:$PATH
export PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH
#export PATH=$HOME/STM32CubeMX:$PATH
export PATH=$HOME/.gem/ruby/3.0.0/bin:$PATH
export PATH=$HOME/.stack/programs/x86_64-linux/stack-2.7.3:$PATH

export CODE=$HOME/spaces
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab
```

`~/.zshrc`:

```
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="muse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git python docker systemd sudo vi-mode
)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

vac()
{
    . $(pdm venv activate "$1")
}

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

export PATH="$PATH":"$HOME/.pub-cache/bin"

export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"

#export CODE=~/spaces

export SAM_CLI_TELEMETRY=0

alias lls="ls -lha --color=always | less -r"
alias lss="ls --color=always | less -r"
alias exstat="expac -H M '%m\t%n' | sort -h"
alias exst="exstat | tail -n 10"
alias lg="lazygit"
alias dm=damastes
alias dp=procrustes

function pipver-col() { curl -s https://pypi.org/rss/project/$1/releases.xml | sed -n 's/\s*<title>\([^<]*\).*/\1/p' ;}
function pipver() { curl -s https://pypi.org/rss/project/$1/releases.xml | sed -n 's/\s*<title>\([^<]*\).*/ \1/p' | paste -sd, ;}
function tpipver() { curl -s https://test.pypi.org/rss/project/$1/releases.xml | sed -n 's/\s*<title>\([^<]*\).*/ \1/p' | paste -sd, ;}

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

eval "$(zoxide init zsh)"
alias cd=z
#source ~/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
#eval "$(starship init zsh)"
```
