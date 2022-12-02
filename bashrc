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

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

alias less='less --RAW-CONTROL-CHARS'
alias grep='grep --color'

LS_OPTS='--color=auto --group-directories-first'
alias ls='ls ${LS_OPTS}'
alias la='ls -la ${LS_OPTS}'
alias ll='ls -l ${LS_OPTS}'

alias git-log='git log --graph \
        --pretty="%Cred%h%Creset -%C(auto)%d %Cgreen(%ad) %C(bold blue)<%an>%n%Creset%B%N" \
        --date=short'

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
