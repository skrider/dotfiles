#!/bin/bash

# get screenshots dir from xdg
SCREENSHOTS_DIR=$(xdg-user-dir PICTURES)/Screenshots

# get most recently modified file in screenshots dir
SCREENSHOT=$(ls -t $SCREENSHOTS_DIR | head -n 1)

# copy screenshot to clipboard using xclip
cat $SCREENSHOTS_DIR/$SCREENSHOT | xclip -selection clipboard -t image/png

