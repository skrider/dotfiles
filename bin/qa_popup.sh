#!/bin/bash

set -o errexit
set -o nounset

DIALOGUES_DIR="$HOME/.sk_dialogues"
NEW_DIALOGUE_OPTION="(new)"

_watch_dialogue () {
  # entr -n : non-interactive mode
  # entr -p : run only when file changed for the first time
  # echo $1 | entr -np "python3 $HOME/.dotfiles/bin/qa_popup.py /_"
  echo $1 | entr -np python3 ~/.dotfiles/bin/qa_popup.py /_
}

# function to run in the popup
_main () {
  options="$(ls "$DIALOGUES_DIR")\n$NEW_DIALOGUE_OPTION"
  option=$(echo -e "$options" | fzf --height 40% --reverse --prompt "Select dialogue: ")
  if [[ "$option" == "$NEW_DIALOGUE_OPTION" ]]; then
    # read in the new dialoge name using read
    read -p "Enter new dialogue name: " option
    touch "$DIALOGUES_DIR/$option"
  fi
  # run the dialogue
  dialogue_path="$DIALOGUES_DIR/$option"
  # run _watch_dialogue in the background and capture PID, redirecting stderr and stdout to /dev/null
  _watch_dialogue "$dialogue_path" &>/tmp/qa_popup.log &
  dialogue_pid=$!
  # run EDITOR in the foreground
  $EDITOR "$dialogue_path"
  # kill _watch_dialogue
  kill $dialogue_pid
}

_main

