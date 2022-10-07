_fpp() {
	tmux capture-pane -J -S - -E - -b "fpp-$1" -t "$1"
	tmux popup \
"tmux show-buffer -b fpp-$1 |"\
"fpp -c 'source /home/sk/.dotfiles/bin/tmux_scripts.sh ; _lambda ' --no-file-checks || true"
	tmux delete-buffer -b "fpp-$1"
}

_lambda() {
    # remove leading junk that fpp adds
    echo $@ | sd '^\./+' '' | xclip -i
    # kill popup forcefully as fpp hangs around
    tmux popup -C
}

_urlview() {
	tmux capture-pane -J -S - -E - -b "urlview-$1" -t "$1"
	tmux popup "tmux show-buffer -b urlview-$1 | urlview || true"
	tmux delete-buffer -b "urlview-$1"
}

