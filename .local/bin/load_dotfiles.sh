#!/bin/bash


error() {
    printf "Error: $1\n" >&2; exit 1
}

[ -d ~/.dotfiles ] && error '~/.dotfiles already exists'

git clone --separate-git-dir=$HOME/.dotfiles https://github.com/jniedi/dotfiles.git $HOME/dotfiles-tmp
cp $HOME/dotfiles-tmp/.* ~  # Copy everything
rm -r $HOME/dotfiles-tmp
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 -k; # NOTE: -k option keeps .zshrc
echo "Everything set!"
