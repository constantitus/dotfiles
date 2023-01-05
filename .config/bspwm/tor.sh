#!/bin/bash
# picom toggle script

if pgrep -x "tor" > /dev/null
then
	doas rc-service tor stop && notify-send "tor service stopped"
else
	doas rc-service tor start && notify-send "tor service started"
fi
