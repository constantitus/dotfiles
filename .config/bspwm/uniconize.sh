#!/bin/bash
# picom toggle script

if pgrep -x "uniconize" > /dev/null
then
	killall uniconize && notify-send "killed uniconize"
else
	 notify-send "starting uniconize" && uniconize &
fi
