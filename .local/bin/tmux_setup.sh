#/usr/bin/env bash

tmuxp load $HOME/dotfiles/config/tmuxp/music.yml -d 
tmuxp load $HOME/dotfiles/config/tmuxp/admin.yml -d
tmuxp load $HOME/dotfiles/config/tmuxp/cheatsheet.yml -d

subjects=(
$HOME/school/complex-analysis/.tmuxp_init.yml
$HOME/school/information-security/.tmuxp_init.yml
$HOME/school/numerical-methods-for-computer-science/.tmuxp_init.yml
$HOME/school/analysis-II/.tmuxp_init.yml
$HOME/school/introduction-to-machine-learning/.tmuxp_init.yml
$HOME/school/information-retrieval/.tmuxp_init.yml
$HOME/school/intellectual-property/.tmuxp_init.yml
)

for file in "${subjects[@]}"; do
    dir=$(dirname $file)
    SUBJECT_NAME=$(echo $dir | rev | cut -d/ -f1 | rev) SUBJECT_PATH=$dir tmuxp load $file -d
done
