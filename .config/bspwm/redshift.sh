#!/bin/bash
# redshift toggle script

if pgrep -x "redshift" > /dev/null
then
	killall redshift && notify-send "killing redshift"
else
  notify-send "starting redfhift" &&
	redshift -c ~/.config/bspwm/redshift.conf &
fi
