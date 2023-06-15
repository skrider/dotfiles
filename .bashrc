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
  if [ -n "$VENV_CMD" ] && [ -z "$VIRTUAL_ENV" ] ; then
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sk/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sk/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/sk/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/sk/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/sk/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/sk/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export MAMBA_NO_BANNER=1


source /home/sk/.bash_completions/sieve.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sk/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/sk/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sk/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/sk/Downloads/google-cloud-sdk/completion.bash.inc'; fi
