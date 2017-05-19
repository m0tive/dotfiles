#!/bin/bash

# Bomb out if we're not in interactive mode
[ -z "$PS1" ] && return

# Tell bash to save parrallel shell history properly
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias ls='ls --color=auto'
alias ldir='ls -ld */'
alias grep='grep --color=auto'
alias addToPath='. $HOME/.addToPath'

case `uname -s` in
	Darwin ) # Mac only setup
	  alias ls='ls -G'
	  ;;
esac

PS1="\u@\h:\W$ "

[ -f $HOME/.bashrc.local ] && source $HOME/.bashrc.local

eval `ssh-agent`
ssh-add
