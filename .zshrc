autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zmodload zsh/complist

export ZSH="$HOME/.oh-my-zsh"


finder() {
    find | fzf
}

zle -N finder
bindkey '^f' finder

PS1="%2~ $ "

plugins=(
wd
)

source $ZSH/oh-my-zsh.sh

# installed using pacman
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh history

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

export DISABLE_AUTO_TITLE="true"

setopt HIST_IGNORE_ALL_DUPS     # Avoid duplicates
setopt SHARE_HISTORY            # Share history between sessions
setopt APPEND_HISTORY           # Append, don't overwrite
setopt INC_APPEND_HISTORY       # Write after each command
setopt HIST_EXPIRE_DUPS_FIRST   # Ensure history is written immediately
setopt AUTOCD                   # change directory just by typing its name
setopt PROMPT_SUBST             # enable command substitution in prompt
setopt MENU_COMPLETE            # Automatically highlight first element of completion menu
setopt LIST_PACKED		        # The completion menu takes less space.
setopt AUTO_LIST                # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD         # Complete from both ends of a word.
setopt appendhistory

set -o vi

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search

alias con='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias hx=helix
alias em=emacs
alias open=xdg-open
alias zat=zathura --fork --page=0
alias nv=nvim
alias ls='ls --color'
alias kbb="brightnessctl --device='tpacpi::kbd_backlight' set"
alias twm='typst watch main.typ ~/build/cheatsheets/$(basename $(pwd))/$(basename $(pwd)).pdf'
