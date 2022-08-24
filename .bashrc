#!/usr/bin/env bash

source ~/.gitstatus/gitstatus.prompt.sh
export PS1='\[\e[0m\]\u\[\e[0m\]@\[\e[0m\]\h \[\e[0m\]\w \[\e[0m\]${GITSTATUS_PROMPT}\n\[\e[0m\]\$\[\e[0m\] '

. "$HOME/.cargo/env"
