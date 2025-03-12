# set -e
set -u
set -x


sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://mise.jdx.dev/rpm/mise.repo
sudo dnf install -y mise
mise trust ~

mise use -g chezmoi@latest lazygit@latest

ssh="git@github.com:Tyrn/dotfiles.git"
https="https://github.com/Tyrn/dotfiles.git"

rm -rf ~/.local/share/chezmoi

~/.local/share/mise/shims/chezmoi init "$https"
