#!/bin/bash
# picom toggle script

if pgrep -x "picom" > /dev/null
then
	killall picom && notify-send "killing picom"
else
  notify-send "starting picom" &&
	picom  --config ~/.config/bspwm/picom.conf &
fi
