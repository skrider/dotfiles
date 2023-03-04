#!/bin/bash

mutt=0
brain3=0
# parse options --mutt with alias -m, --brain3 with alias -b, --help
while [ $# -gt 0 ]; do
    case "$1" in
        -m | --mutt)
            mutt=1
            ;;
        -b | --brain3)
            brain3=1
            ;;
        -h | --help)
            echo "Usage: $0 [-m|--mutt] [-b|--brain3] [-h|--help]"
            exit 0
            ;;
        *)
            echo "Usage: $0 [-m|--mutt] [-b|--brain3] [-h|--help]"
            exit 1
            ;;
    esac
    shift
done

# if mutt is requested, start mutt
if [[ $mutt -eq 1 ]]; then
    MUTT_SESSION=mutt
    MUTT_CMD=mutt
    tmux new-session -d -s $MUTT_SESSION $MUTT_CMD
    # create several tabs in the mutt session running mutt
    tmux new-window -t $MUTT_SESSION:2 $MUTT_CMD
    tmux new-window -t $MUTT_SESSION:3 $MUTT_CMD
    tmux new-window -t $MUTT_SESSION:4 $MUTT_CMD
    tmux new-window -t $MUTT_SESSION:5 $MUTT_CMD
fi

# if brain3 is requested, start brain3
if [[ $brain3 -eq 1 ]]; then
    BRAIN3_SESSION=brain3
    tmux new-session -d -s $BRAIN3_SESSION
fi

