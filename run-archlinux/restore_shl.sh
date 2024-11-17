#!/usr/bin/env bash
#|---/ /+---------------------------+---/ /|#
#|--/ /-| Script to configure shell |--/ /-|#
#|-/ /--| Prasanth Rangan           |-/ /--|#
#|/ /---+---------------------------+/ /---|#

# This is an edited script from HyDE project, https://github.com/prasanthrangan/hyprdots
# The purpose is to add plugins from restore_zsh.lst, if oh-my-zsh-git package
# from AUR is already present. Update plugins list in ~/.zshrc manually.

scrDir=$(dirname "$(realpath "$0")")

pkg_installed() {
    local PkgIn=$1

    if pacman -Qi "${PkgIn}" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# add zsh plugins
if pkg_installed zsh && pkg_installed oh-my-zsh-git; then

    # set variables
    Zsh_rc="${ZDOTDIR:-$HOME}/.zshrc"
    Zsh_Path="/usr/share/oh-my-zsh"
    Zsh_Plugins="$Zsh_Path/custom/plugins"
    Fix_Completion=""

    # generate plugins from list
    while read r_plugin; do
        z_plugin=$(echo "${r_plugin}" | awk -F '/' '{print $NF}')
        if [ "${r_plugin:0:4}" == "http" ] && [ ! -d "${Zsh_Plugins}/${z_plugin}" ]; then
            sudo git clone "${r_plugin}" "${Zsh_Plugins}/${z_plugin}"
        fi
        if [ "${z_plugin}" == "zsh-completions" ] && [ "$(grep 'fpath+=.*plugins/zsh-completions/src' "${Zsh_rc}" | wc -l)" -eq 0 ]; then
            Fix_Completion='\nfpath+=${ZSH_CUSTOM:-${ZSH:-/usr/share/oh-my-zsh}/custom}/plugins/zsh-completions/src'
        else
            [ -z "${z_plugin}" ] || w_plugin+=" ${z_plugin}"
        fi
    done < <(cut -d '#' -f 1 "${scrDir}/restore_zsh.lst" | sed 's/ //g')

#    # update plugin array in zshrc
#    echo -e "\033[0;32m[SHELL]\033[0m installing plugins (${w_plugin} )"
#    sed -i "/^plugins=/c\plugins=(${w_plugin} )${Fix_Completion}" "${Zsh_rc}"
fi

## set shell
#if [[ "$(grep "/${USER}:" /etc/passwd | awk -F '/' '{print $NF}')" != "${myShell}" ]]; then
#    echo -e "\033[0;32m[SHELL]\033[0m changing shell to ${myShell}..."
#    chsh -s "$(which "${myShell}")"
#else
#    echo -e "\033[0;33m[SKIP]\033[0m ${myShell} is already set as shell..."
#fi
