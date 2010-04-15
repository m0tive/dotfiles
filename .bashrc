# Bomb out if we're not in interactive mode
[ -z "$PS1" ] && return

# Tell bash to save parrallel shell history properly
shopt -s histappend

alias ls='ls --color=auto'
alias grep='grep --color=auto'

case `uname -s` in
	Darwin ) # Mac only setup
	  alias ls='ls -G'
	  ;;
esac

PS1="\u@\h:\W$ "

if which -s bzr; then
	if test -n "`bzr status $HOME`"; then
		echo "WARNING : User config files are uncommited"
	fi
fi
