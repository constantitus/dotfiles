#!/bin/bash
# redshift toggle script

if pgrep -x "redshift" > /dev/null
then
	killall redshift
else
	redshift -c ~/.config/bspwm/redshift.conf &
fi
