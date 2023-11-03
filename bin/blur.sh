#!/bin/sh
#
current=$(hyprctl getoption decoration:blur:enabled | awk 'FNR == 2 {print $2}')

case $current in
    1)
        hyprctl keyword decoration:blur:enabled 0
        ;;
    0)
        hyprctl keyword decoration:blur:enabled 1
        ;;
esac
