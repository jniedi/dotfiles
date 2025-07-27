#!/usr/bin/env zsh

function error() {
    printf "Error: $1\n" >&2; exit 1
}

[ -d ~/.dotfiles ] && error '~/.dotfiles already exists'

git clone --separate-git-dir=$HOME/.dotfiles https://github.com/jniedi/dotfiles.git /tmp/dotfiles-tmp
# Copy everything
cp -r /tmp/dotfiles-tmp/.* ~
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 -k; # NOTE: -k option keeps .zshrc

alias con='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
con config status.showUntrackedFiles no

echo "Everything set!"
