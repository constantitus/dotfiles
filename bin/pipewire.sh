#!/bin/sh
# For some reason, having pipewire-pulse work on
# my system was an apsolute pain in the ass.
# This sctipt works so I ain't touching it no more.

export PIPEWIRE_RUNTIME_DIR=/run/user/1000

pkill -u "${USER}" -x pipewire\|wireplumber 1>/dev/null 2>&1
/usr/bin/pipewire &
/usr/bin/pipewire -c pipewire-pulse.conf &
sleep 1
# sh $HOME/.config/bspwm/carla.sh &
exec /usr/bin/wireplumber
