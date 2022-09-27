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
# alacritty
echo Starting alacritty
start_alacritty () {
	alacritty_window_name="alacritty_terminal"
	# start detached alacritty
	alacritty --title=$alacritty_window_name &
	# poll wmctrl until alacritty is found
	while [[ ! $(wmctrl -l) =~ $alacritty_window_name ]]
	do
		$(which sleep) 0.1
	done
	# maximize and switch to alacritty
	wmctrl -r $alacritty_window_name -b add,fullscreen
	sleep 0.05
	wmctrl -s 2
	sleep 0.05
	wmctrl -R $alacritty_window_name
}
start_alacritty &

