# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "chivalryq/git-alias"
plug "Aloxaf/fzf-tab"
plug "Freed-Wu/fzf-tab-source"
plug "mfaerevaag/wd"

# Load and initialise completion system
autoload -Uz compinit
compinit

# ----------------------
# Old zshrc

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

alias lt='latexmk -norc -halt-on-error -outdir=output -auxdir=aux'
alias ltc='latexmk -pdf -outdir=output -auxdir=aux -pvc --shell-escape'
alias ltcq='latexmk -pdf -outdir=output -auxdir=aux -pvc --shell-escape -quiet'
alias afk='systemctl suspend'
alias afkl='systemctl suspend && swaylock'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='dirs -v'
alias md='mkdir -p'
alias nv='nvim'
alias vim='nvim'
alias zat='zathura -P 0 &>/dev/null'
alias -g G='| grep'
alias -g L='| less' 
alias -g ...='../..'
alias con='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' \
      conla="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all" 

for command in mount umount sv pacman su shutdown poweroff reboot ; do
    alias $command="sudo $command"
done; unset command


# Use $XINITRC variable if file exists.
[ -f "$XINITRC" ] && alias startx='startx $XINITRC'

function zd() { cd \"$(zoxide query -i)\" }
eval "$(zoxide init zsh)"
