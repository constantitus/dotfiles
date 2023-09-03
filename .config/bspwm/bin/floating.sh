#!/bin/sh
# Forces windows to open either in floating or tiling
bspc rule -l | tail -n 1 > ~/.config/bspwm/float.txt
if grep -q "floating" ~/.config/bspwm/float.txt
then
  notify-send "tiling"
  bspc rule -a '*' state=tiled
else
  notify-send "floating"
  bspc rule -a '*' state=floating
fi
