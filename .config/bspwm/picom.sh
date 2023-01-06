#!/bin/bash
# picom toggle script

if pgrep -x "picom" > /dev/null
then
	killall picom
else
	picom --experimental-backend --config ~/.config/bspwm/picom.conf &
fi
