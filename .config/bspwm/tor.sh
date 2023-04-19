#!/bin/bash
# picom toggle script

if pgrep -x "tor" > /dev/null
then
	doas rc-service tor stop && notify-send "stopping tor service"
else
	doas rc-service tor start && notify-send "starting tor service"
fi
