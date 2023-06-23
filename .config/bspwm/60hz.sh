# Script to set rate of my primary monitor to 60hz
# cause produces a shit-ton of heat
xrandr --rate 60
xrandr --output DisplayPort-1 --primary --rate 60
xrandr --output HDMI-A-1 --auto --rate 60 --right-of DisplayPort-1
