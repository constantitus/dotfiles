#!/bin/sh

rnd="$RANDOM$RANDOM$RANDOM"

if [ "$2" == "2" ]; then
  g="+1920+0"
fi
if [[ "$1" =~ ^(l|landscape|-l)$ ]]; then
  set -- ~/Pictures/Wallpapers/*
  file="$(eval 'echo "${'$((1 + $rnd % $#))'}"')"
  feh --bg-fill "$file"
  echo $file
elif [[ "$1" =~ ^(p|portrait|-p)$ ]]; then
  set -- ~/Pictures/Wallpapers/*
  file="$(eval 'echo "${'$((1 + $rnd % $#))'}"')"
  feh --geometry "$g" --bg-fill "$file"
else
  echo -e "usage: randombg.sh <option>\n\t -p (p, portrait)\n\t -l (l,landscape)"
fi

