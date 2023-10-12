# ~/.bashrc

# Source global definitions.
if [ -r /etc/bashrc ]; then
	. /etc/bashrc
fi

export HISTSIZE=4096
export HISTCONTROL=ignoredups:erasedups

GC="\[\e[01;32m\]"
BC="\[\e[01;34m\]"
OC="\[\e[00;33m\]"
XC="\[\e[m\]"
PS1="$GC[$BC\w$GC]\n$OC>$XC "

LS_OPS='--color=auto --group-directories-first'
alias ls='exa ${LS_OPS}'
alias ll='exa -l ${LS_OPS}'
alias la='exa -la ${LS_OPS}'

alias less='less --RAW-CONTROL-CHARS'
alias grep='grep --color'

alias vim='nvim'
alias vimvs='nvim -O'
alias vimt='nvim -p'

alias tmx='tmux'
alias tmxa='tmux attach'
alias tmxl='tmux ls'
alias tmxn='tmux new -s '

alias git-log="git log --graph --date=short \
	--pretty='%Cred%h%Creset -%C(auto)%d %Cgreen(%ad) %C(bold blue)<%an>%n%Creset%B%N%n'"

alias vpn_on='sudo /usr/sbin/openvpn \
	--config /etc/openvpn/client/elvees2fa.conf \
	--auth-user-pass /etc/openvpn/client/pass.txt'

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/neovim/bin:$PATH"
. "$HOME/.cargo/env"

# For reomote host, when use kitty with remote tmux
# TERM="xterm-256color"

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
if [ -f $1 ] ; then
	case $1 in
		*.tar.bz2)   tar xjf $1   ;;
		*.tar.gz)    tar xzf $1   ;;
		*.bz2)       bunzip2 $1   ;;
		*.rar)       unrar x $1   ;;
		*.gz)        gunzip $1    ;;
		*.tar)       tar xf $1    ;;
		*.tbz2)      tar xjf $1   ;;
		*.tgz)       tar xzf $1   ;;
		*.zip)       unzip $1     ;;
		*.Z)         uncompress $1;;
		*.7z)        7z x $1      ;;
		*.deb)       ar x $1      ;;
		*.tar.xz)    tar xf $1    ;;
		*.tar.zst)   tar xf $1    ;;
		*)           echo "'$1' cannot be extracted via ex()" ;;
	esac
else
	echo "'$1' is not a valid file"
fi
}
