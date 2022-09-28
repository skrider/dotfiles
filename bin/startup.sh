#!/bin/bash

# spotifyd
echo Starting spotifyd
spotifyd &
# nvidia settings
# sh -c '/usr/bin/nvidia-settings --load-config-only' &
# unclutter
echo Starting unclutter
pkill unclutter
unclutter -idle 1 -regex -not 'Firefox|Gpick|LibreOffice' &
# im-launch
# sh -c 'if [ "x$XDG_SESSION_TYPE" = "xwayland" ] ; then exec env IM_CONFIG_CHECK_ENV=1 im-launch true; fi' &
# firefox
echo Starting firefox
firefox &
# kitty
echo Starting kitty
start_kitty () {
	kitty_window_name="kitty_terminal"
	# start detached kitty
	kitty --title=$kitty_window_name &
	# poll wmctrl until kitty is found
	while [[ ! $(wmctrl -l) =~ $kitty_window_name ]]
	do
		$(which sleep) 0.1
	done
	# note for posterity - wmctrl is really shitty and not worth messing with. Most flags don't even work.
 	wmctrl -R $kitty_window_name
}
start_kitty &

