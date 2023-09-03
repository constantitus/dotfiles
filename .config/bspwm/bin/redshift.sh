#!/bin/bash
# redshift toggle script

if pgrep -x "redshift" > /dev/null
then
	killall redshift && notify-send "killing redshift" &&
  wait 1 &&
  redshift -P
else
  notify-send "starting redfhift" &&
	redshift -P -c ~/.config/bspwm/redshift.conf &
fi
