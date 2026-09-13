#!/usr/bin/env bash
# Installs dotfiles: oh-my-zsh + plugins, Vundle + vim plugins, symlinks.
# Safe to re-run. Existing non-symlink configs are moved to *.bak.<timestamp>.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OMZ="$HOME/.oh-my-zsh"
OMZ_CUSTOM="${ZSH_CUSTOM:-$OMZ/custom}"

for cmd in git zsh vim curl; do
    command -v "$cmd" >/dev/null || { echo "Missing $cmd: sudo apt install $cmd" >&2; exit 1; }
done

clone_or_pull() {
    if [ -d "$2/.git" ]; then
        git -C "$2" pull --ff-only -q
    else
        git clone --depth=1 -q "$1" "$2"
    fi
}

link() {
    if [ -e "$2" ] && [ ! -L "$2" ]; then
        mv "$2" "$2.bak.$(date +%s)"
    fi
    ln -sfn "$1" "$2"
}

link "$DOTFILES/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/.vimrc" "$HOME/.vimrc"
link "$DOTFILES/.ideavimrc" "$HOME/.ideavimrc"

if [ ! -d "$OMZ" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
clone_or_pull https://github.com/zsh-users/zsh-autosuggestions "$OMZ_CUSTOM/plugins/zsh-autosuggestions"
clone_or_pull https://github.com/zsh-users/zsh-syntax-highlighting "$OMZ_CUSTOM/plugins/zsh-syntax-highlighting"

clone_or_pull https://github.com/VundleVim/Vundle.vim "$HOME/.vim/bundle/Vundle.vim"
vim -E -s -u "$HOME/.vimrc" +PluginInstall +qall </dev/null || true

if [ "$(basename "${SHELL:-}")" != "zsh" ] && [ -t 0 ]; then
    chsh -s "$(command -v zsh)"
fi

echo "Done. Open a new terminal to start zsh."
