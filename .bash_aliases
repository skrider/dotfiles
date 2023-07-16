alias k="kubectl"

# cd into nix channel
alias cdnix='cd /nix/var/nix/profiles/per-user/root/channels/nixpkgs'

# modify xclip to use the correct clipboard
alias xclip='xclip -selection c'

# launch qtconsole in jupyter
alias jqt='jupyter qtconsole --JupyterWidget.include_other_output=True --existing'

# have ranger store last directory in a temporary file, then switch to this file when exited
alias rgr='ranger --choosedir=$HOME/.rangerdirs/$(basename $(tty)) ; cd $(cat $HOME/.rangerdirs/$(basename $(tty)))'

# same for lf
alias lf='lf -last-dir-path $HOME/.local/share/lf/lastdir/$(basename $(tty)) ; cd $(cat $HOME/.local/share/lf/lastdir/$(basename $(tty)))'

# logout of gnome
alias glogout='gnome-session-quit'

# find directory. If none was chosen, echo ., the current directory
alias ffd='fd -H --type d | fzf || echo .'

# find files
alias fff='fd -H | fzf'
alias fcd='cd $(ffd)'
alias fco='code $(fff)'
alias fnv='nvim $(fff)'

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

# make jupyter_ascending synced pair
alias jupyter_ascending_sync='python -m jupyter_ascending.scripts.make_pair --base'

# send a notification
alias notify='notify-send -u critical -t 10000 shell'

# init conda for session
alias conda_bootstrap='eval "$($HOME/mambaforge/bin/conda shell.bash hook)"'

# start spt in kitty window
alias kspt='nohup kitty --class spt spt &> /dev/null &'

# fische from microphone
alias fische_mic='fische --device alsa_input.pci-0000_00_1f.3-platform-sof_sdw.HiFi__hw_sofsoundwire_4__source'

