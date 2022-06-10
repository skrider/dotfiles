alias psl='powershell -nologo'
alias xclip='xclip -selection c'
alias brain2='code ~/brain2/dendron.code-workspace'
alias f='fcd'
alias glogout='gnome-session-quit'
alias nextonic='tectonic -X'
alias new='alacritty &'
alias ffd='fd -H --type d | fzf || echo .'
alias fff='fd -H | fzf'
alias fcd='cd $(ffd)'
alias fco='code $(fff)'
alias fhi='cat ~/.bash_history | sort | uniq | fzf'
alias ibash='bash -l'

ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/local/bin/ranger "$@"
    else
        exit
    fi
}


