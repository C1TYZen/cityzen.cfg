# Source global definitions.
if [ -r /etc/bashrc ]; then
	. /etc/bashrc
fi

PS1=""
PS1+="\e[01;95m\u\e[m@\e[01;32m\h "
PS1+="\e[01;34m"
PS1+="[j\j] "
PS1+="[\t] "
PS1+="[\w]\e"
PS1+="[m\n"
PS1+="$ "

export LS_OPTS='--color=auto --group-directories-first'

alias less='less --RAW-CONTROL-CHARS'
alias ls='ls ${LS_OPTS}'
alias la='ls -la ${LS_OPTS}'
alias ll='ls -l ${LS_OPTS}'
alias grep='grep --color'
