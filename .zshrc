autoload -Uz compinit               # Load and initialise completion system
compinit

source <(sk --shell zsh)

PS1="%2~ $ "

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

export DISABLE_AUTO_TITLE="true"

setopt AUTOCD                   # change directory just by typing its name
setopt PROMPT_SUBST             # enable command substitution in prompt
setopt MENU_COMPLETE            # Automatically highlight first element of completion menu
setopt LIST_PACKED		        # The completion menu takes less space.
setopt AUTO_LIST                # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD         # Complete from both ends of a word.
setopt appendhistory

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -Uz vcs_info
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search

alias con='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias open=xdg-open
alias zat=zathura --fork --page=0
alias nv=nvim
alias kbb="brightnessctl --device='tpacpi::kbd_backlight' set"
