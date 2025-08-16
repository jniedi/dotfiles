# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ---- fzf/sk integration (assuming sk supports bash) ----
# This loads sk (or fzf) keybindings and completion
source <(sk --shell bash)

# ---- Prompt ----
PS1="\w \$ "

# ---- History Settings ----
HISTFILE=~/.bash_history
HISTSIZE=1000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

export EDITOR=nvim
export PATH="./usr/lib/ccache/bin:$HOME/.local/bin:/usr/local/texlive/2025/bin/x86_64-linux:/usr/local/texlive/2023/bin/x86_64-linux:$PATH"

set -o vi

bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'

# ---- AutoCD alternative ----
# Bash doesn't support AUTOCD natively. Use a function or bind for it if needed.

# ---- Aliases ----
alias con="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias open='xdg-open'
alias zat='zathura --fork --page=0'
alias nv='nvim'
