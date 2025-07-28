# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "Aloxaf/fzf-tab"
plug "Freed-Wu/fzf-tab-source"

# Load and initialise completion system
autoload -Uz compinit
compinit

source <(fzf --zsh)

PS1="%n@%m:%2~ $ "

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export DISABLE_AUTO_TITLE="true"
export LESSOPEN="|lesspipe.sh %s"

setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt appendhistory

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search

alias ltc='latexmk -pdf -outdir=output -auxdir=aux -pvc --shell-escape'
alias ltcq='latexmk -pdf -outdir=output -auxdir=aux -pvc --shell-escape -quiet'
alias nv='nvim'
alias vim='nvim'
alias zat='zathura -P 0 &>/dev/null'
alias con='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias conla="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all" 
alias wd=z
function zd() { cd $(zoxide query -i) }

eval "$(zoxide init zsh)"
