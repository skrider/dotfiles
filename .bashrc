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

export BAT_THEME=ansi

source ~/.bash_aliases
export EDITOR=nvim
export GCM_CREDENTIAL_STORE=gpg

. "$HOME/.cargo/env"

complete -C '/usr/local/bin/aws_completer' aws

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sk/.miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sk/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sk/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sk/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

