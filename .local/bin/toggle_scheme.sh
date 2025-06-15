#!/usr/bin/env zsh

TFILE=~/.cache/light
if [ -f $TFILE ]; then
    rm $TFILE
    sed -i 's/light.toml/dark.toml/' ~/.config/alacritty/alacritty.toml
else
    touch $TFILE
    sed -i 's/dark.toml/light.toml/' ~/.config/alacritty/alacritty.toml
fi
