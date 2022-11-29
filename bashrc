# Source global definitions.
if [ -r /etc/bashrc ]; then
	. /etc/bashrc
fi

PS1="["
PS1+="\e[01;95m\u\e[m"
PS1+="@"
PS1+="\e[01;32m\h\e[m "
PS1+="\e[01;34m\w\e[m"
PS1+="]\n$ "

export LS_OPTS='--color=auto --group-directories-first'

alias less='less --RAW-CONTROL-CHARS'
alias ls='ls ${LS_OPTS}'
alias la='ls -la ${LS_OPTS}'
alias ll='ls -l ${LS_OPTS}'
alias grep='grep --color'
