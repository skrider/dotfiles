#!/usr/bin/env bash

_edit_wo_executing() {
    local editor="${EDITOR:-nano}"
    tmpf="$(mktemp).sh"
    echo '#!/bin/bash' > "$tmpf"
    printf '%s\n' "$READLINE_LINE" \
        | shfmt >> "$tmpf"
    $editor "$tmpf"
    READLINE_LINE="$(tail -n +2 < "$tmpf")"
    READLINE_POINT="${#READLINE_LINE}"
    rm "$tmpf"
}

if [[ $- == *i* ]]; then
	source ~/.gitstatus/gitstatus.prompt.sh
	export PS1='\[\e[0m\]\u\[\e[0m\]@\[\e[0m\]\h \[\e[0m\]\w \[\e[0m\]${GITSTATUS_PROMPT} $(last=$?; [[ $last != 0 ]] && echo $last)\n\[\e[0m\]\$\[\e[0m\] '
	bind -m vi-command -x '"v":_edit_wo_executing'
fi

source ~/.bash_aliases
source ~/.bash_theme.bash
source ~/.bash_env
export EDITOR=nvim
export GCM_CREDENTIAL_STORE=gpg

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# virtual env auto init
_venv_hook () {
  # if variable VENV_CMD is set and VIRTUAL_ENV is not, activate it
  if [ -n "$VENV_CMD" ] && [ -z "$VIRTUAL_ENV" ]; then
    eval "$VENV_CMD"
  fi

  # if variable VENV_CMD is not set and VIRTUAL_ENV is, deactivate it
  if [ -z "$VENV_CMD" ] && [ -n "$VIRTUAL_ENV" ]; then
    deactivate
  fi
}
export _venv_hook
# add hook to PROMPT_COMMAND
export PROMPT_COMMAND="_venv_hook;$PROMPT_COMMAND"

# add direnv hook after _venv_hook
eval "$(direnv hook bash)"

. "$HOME/.cargo/env"

complete -C '/usr/local/bin/aws_completer' aws


