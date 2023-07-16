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
    export PS1=\
'\[\e[0m\]$(s=$?; if [[ $s != 0 ]]; then echo "$s "; fi; unset s)'\
'\[\e[0m\]\[\033[01;32m\]\u@\h\[\033[00m\]:'\
'\[\e[0m\]\[\033[01;34m\]\w\[\033[00m\] '\
'\[\e[0m\]$(if [[ ${#DIRENV_PROMPT} == 0 ]]; then echo ""; else eval printf "\"$DIRENV_PROMPT\""; printf " "; fi)'\
'\[\e[0m\]$(if [[ ${#GITSTATUS_PROMPT} == 0 ]]; then echo ""; else echo "$GITSTATUS_PROMPT"; fi)'\
'\n'\
'\[\e[0m\] \$'\
'\[\e[0m\] '
	bind -m vi-command -x '"v":_edit_wo_executing'
fi

source ~/.bash_aliases
export EDITOR=nvim
export GCM_CREDENTIAL_STORE=gpg

# add direnv hook after _venv_hook
eval "$(direnv hook bash)"

. "$HOME/.cargo/env"

complete -C '/usr/local/bin/aws_completer' aws

export MAMBA_NO_BANNER=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sk/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/sk/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sk/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/sk/Downloads/google-cloud-sdk/completion.bash.inc'; fi

