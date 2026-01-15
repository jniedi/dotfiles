#!/usr/bin/env zsh

sudo pacman -S --needed git base-devel

mkdir -p ~/repos
rm -fr ~/repos/yay
git clone https://aur.archlinux.org/yay.git ~/repos/yay
cd ~/repos/yay
makepkg -si
cd -
