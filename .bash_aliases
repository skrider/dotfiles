# modify xclip to use the correct clipboard
alias xclip='xclip -selection c'

# have ranger store last directory in a temporary file, then switch to this file when exited
alias rgr='ranger --choosedir=$HOME/.rangerdirs$(basename $(tty)) ; cd $(cat $HOME/.rangerdirs$(basename $(tty)))'

# logout of gnome
alias glogout='gnome-session-quit'

# find directory. If none was chosen, echo ., the current directory
alias ffd='fd -H --type d | fzf || echo .'

# find files
alias fff='fd -H | fzf'
alias fcd='cd $(ffd)'
alias fco='code $(fff)'

# look through bash history
alias fhi='cat ~/.bash_history | sort | uniq | fzf'

# edit faaaaast
alias nv="nvim"

# new kitty window
alias nkitty="nohup kitty &> /dev/null &"

# directory mark, maintains state in env
alias md='SKRIDER_DIRS=${SKRIDER_DIRS:=0};'\
'SKRIDER_DIRS=$(($SKRIDER_DIRS + 1));'\
'alias cd$SKRIDER_DIRS="cd $(pwd)";'\
'echo $SKRIDER_DIRS'

# cd to dotfiles
alias cdd="cd $HOME/.dotfiles"

