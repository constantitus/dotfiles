#!/bin/sh

# Randomly picks a background and accent color

export PATH="~/.config/bspwm/bin:$PATH"
rnd="$RANDOM$RANDOM$RANDOM"

# if [ "$2" == "2" ]; then
#    g="+1920+0"
# fi

if [[ "$1" =~ ^(l|landscape|-l)$ ]]; then
    set -- ~/Pictures/Wallpapers/Landscape/*
    file="$(eval 'echo "${'$((1 + $rnd % $#))'}"')"
    feh --bg-fill "$file"
    echo $file
    ac=`$HOME/.config/bspwm/bin/gethex.sh "$file" "l"`
    dc=`$HOME/.config/bspwm/bin/gethex.sh "$file" "d"`

elif [[ "$1" =~ ^(p|portrait|-p)$ ]]; then
    set -- ~/Pictures/Wallpapers/Portrait/*
    file="$(eval 'echo "${'$((1 + $rnd % $#))'}"')"
    feh --bg-fill "$file"
    # feh --geometry "$g" --bg-fill "$file"
    ac=`$HOME/.config/bspwm/bin/gethex.sh "$file" "l"`
    dc=`$HOME/.config/bspwm/bin/gethex.sh "$file" "d"`
else
    echo -e "usage: randombg.sh <option>\n\t -p (p, portrait)\n\t -l (l,landscape)"
    exit
fi


bspc config normal_border_color "$dc"
bspc config active_border_color "$dc"
bspc config focused_border_color "$ac"

