#!/usr/bin/env bash


_edit_wo_executing() {
    local editor="${EDITOR:-nano}"
    tmpf="$(mktemp).sh"
    printf '%s\n' "$READLINE_LINE" > "$tmpf"
    $editor "$tmpf"
    READLINE_LINE="$(<"$tmpf")"
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
export EDITOR=nvim
export GCM_CREDENTIAL_STORE=gpg

. "$HOME/.cargo/env"

complete -C '/usr/local/bin/aws_completer' aws

