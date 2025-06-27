#!/usr/bin/env zsh

TFILE=~/.cache/light
if [ -f $TFILE ]; then
    rm $TFILE
else
    touch $TFILE
fi
sed -i 's/background/TEMP/' ~/.config/alacritty/alacritty.toml
sed -i 's/foreground/background/' ~/.config/alacritty/alacritty.toml
sed -i 's/TEMP/foreground/' ~/.config/alacritty/alacritty.toml

