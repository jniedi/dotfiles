while ((1)) ; do
sel="`find -type d | fzf`"
mpv --no-video $sel
done
