#!/usr/bin/env zsh

sudo pacman -S --needed git base-devel

mkdir -p ~/repos
rm -r ~/repos/yay
git clone https://aur.archlinux.org/yay.git ~/repos/yay
cd ~/repos/yay
makepkg -si
cd -
