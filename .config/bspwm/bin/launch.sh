#!/usr/bin/sh

sleep 1

# redshift -c ~/.config/bspwm/redshift.conf &
# I personally use redshift, but excluded it from
# my dotfiles because it messes with the rice

bspc wm -r
# reloading bspwm again because, for some reason
# just executing bspwmrc isn't enough to have bspwm
# use the config and it'd just load a blackscreen

# sh .config/bspwm/picom.sh &

sh ~/.config/bspwm/uniconize.sh &

sleep 5
doas corectrl &
