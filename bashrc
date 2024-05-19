# ~/.bashrc

# Source global definitions
if [ -r /etc/bashrc ]; then
	. /etc/bashrc
fi

# Load inputrc
bind -f ~/.inputrc

export HISTSIZE=4096
export HISTCONTROL=ignoredups:erasedups

GC="\[\e[01;32m\]"
BC="\[\e[01;34m\]"
OC="\[\e[00;33m\]"
XC="\[\e[m\]"
PS1="$GC[$BC\W$GC]$XC $OC>$XC "

LS_OPS="-h --color=auto --width=$((COLUMNS/2)) --group-directories-first"
alias ls="ls ${LS_OPS}"
alias l="ls ${LS_OPS}"
alias la="ls -A ${LS_OPS}"
alias ll="ls -l ${LS_OPS}"
alias lla="ls -lA ${LS_OPS}"

alias less="less --RAW-CONTROL-CHARS"
alias grep="grep --color"

alias vim="nvim"
alias vims="nvim -o"
alias vimsp="nvim -o"
alias vimv="nvim -O"
alias vimvs="nvim -O"
alias vimt="nvim -p"
alias vimtb="nvim -p"

alias tmx="tmux"
alias tmxa="tmux attach"
alias tmxl="tmux ls"
alias tmxn="tmux new -s "

alias gitlog="git log --graph --date=short \
	--pretty='%Cred%h%Creset -%C(auto)%d %Cgreen(%ad) %C(bold blue)<%an>%n%Creset%B%N%n'"

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
