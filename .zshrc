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

PS1="%m:%2~ $ "

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

alias lt='latexmk -norc -halt-on-error -outdir=output'
alias ltc='latexmk -pdf -outdir=output -pvc --shell-escape'
alias la='ls -lah'
alias afk='systemctl suspend'
alias afkl='systemctl suspend && swaylock'
alias ll='eza -lagoMF --icons -s modified --hyperlink --group-directories-first  --git --git-repos --time-style long-iso'
alias llt='eza -alM --icons --tree -s modified --hyperlink --group-directories-first  --git --git-repos'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='dirs -v'
alias md='mkdir -p'
alias rmzip='rm -r *.zip'
alias rmr='rm -r'
alias pdw='pwd'
alias manp='man-preview'
alias cl='clear'
alias nv='nvim'
alias zat='zathura -P 0 &>/dev/null'
alias q='exit'
alias dirs='dirs -v'
alias pd='pushd -q'
alias gd='popd -q'
alias pac='sudo pacman -S'
alias con="nv -c /stopped"
alias texsym="zat $HOME/resources/references/symbols-a4.pdf &"
alias python=/usr/bin/python3
alias py=/usr/bin/python3
alias copypath='pwd | xclip -sel clipboard'


# tmux(p)
alias ta="tmux attach -t" \
      tls="tmux ls" \
      tks="tmux kill-server" \
      tnwn="tmux new-window -n" \
      tnw="tmux new-window" \
      tns="tmux new -s" \
      td="tmux detach" \
      tksess='tmux kill-session' \
      tl="tmuxp load" \
      tlfs='tmuxp load $(fd session.yml | fzf --height=~100%)'


alias o="xdg-open"
alias time=/usr/bin/time
alias eth_vpn='sudo openconnect -u jniederer@student-net.ethz.ch --useragent=AnyConnect -g student-net sslvpn.ethz.ch'

# Use $XINITRC variable if file exists.
[ -f "$XINITRC" ] && alias startx='startx $XINITRC'

# sudo not required for some system commands
for command in mount umount sv pacman updatedb su shutdown poweroff reboot ; do
	alias $command="sudo $command"
done; unset command


# Verbosity and settings that you pretty much just always are going to want.
alias \
	cp="cp -iv" \
	mv="mv -iv" \
	rm="rm -vI" \
	bc="bc -ql" \
	rsync="rsync -vrPlu" \
	mkd="mkdir -pv" \
	ffmpeg="ffmpeg -hide_banner"

# Colorize commands when possible.
alias \
	ls="ls -hN --color=auto --group-directories-first" \
	grep="grep --color=auto" \
	diff="diff --color=auto" \
	ccat="highlight --out-format=ansi" \
	ip="ip -color=auto"

alias \
	ka="killall" \
	g="git" \
	YT="youtube-viewer" \
	sdn="shutdown -h now" \
	e='$EDITOR' \
	v='$EDITOR' \
	p="pacman" \
	xi="sudo xbps-install" \
	xr="sudo xbps-remove -R" \
	xq="xbps-query" \
    ff="firefox" \


alias -g G='| grep'   
alias -g L='| less' 
alias -g ...='../..'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'



zd() {
  cd "$(zoxide query -i)"
}




eval "$(zoxide init zsh)"

# vim: set ft=zsh:
