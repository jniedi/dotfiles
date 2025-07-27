#!/usr/bin/env zsh

cd /tmp

sudo pacman -S --needed git base-devel
if ! command yay --version &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git ~/repos/yay || error "failed to clone yay"
    cd ~/repos/yay
    makepkg -si
    cd -
fi
