#!/usr/bin/env bash

source ~/.gitstatus/gitstatus.prompt.sh
export PS1='\[\e[0m\]\u\[\e[0m\]@\[\e[0m\]\h \[\e[0m\]\w \[\e[0m\]${GITSTATUS_PROMPT} $(last=$?; [[ $last != 0 ]] && echo $last)\n\[\e[0m\]\$\[\e[0m\] '
source ~/.bash_aliases
export EDITOR=nvim

. "$HOME/.cargo/env"
