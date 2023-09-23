#!/bin/bash

## Stolen from https://github.com/sayan01/scripts and
## merged the stuff I need into a single file for convenience

usage() {
    echo "usage: gethex.sh [/pathtofile] [light/dark/all] [delta]"
    echo "l or - only light or dark hex value"
    echo "a - all values"
    echo "delta - difference between light and dark"
    echo "to set delta, you need to set the second argument l, d or a"
    exit 1
}

error(){
	echo "$@"
	exit 1
}
src="$1"

# path="${HOME}/.config/wall"

if test -z "$1"; then usage; fi
if test ! -r "$src" ; then error "File $src does not exist or is unreadable"; fi
if test -d "$src" ; then error "$src is not a image file, it is a directory"; fi
if test -d "$src"; then error "$src is a directory, not an image" ; fi
if ! `file "$src" \
    | grep -qE 'image|bitmap' \
    && identify "$1" >/dev/null 2>&1`; then
    error "$src is not a valid image file" ; fi


delta="$3"
if test -z "$3"; then delta=50; fi

## No need to create files or change path...
# if ! mkdir -p "$path"; then echo "unable to create directory"; exit 1; fi
# cp -f "$src" "${path}/"
# cd "$path" || exit 1
# src="$(basename "$src")"


dc="$(convert "$src" -scale 50x50! -depth 8 +dither -colors 8 -format "%c" histogram:info: \
    | sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p' \
    | sort -r -n -k 1 -t "," \
    | head -n1 \
    | cut -d, -f2 \
    | cut -c1-7)"

## I always want the accentcolor to be lighter so
tone=-${delta}

## So I got rid of this
# get if image color is light or dark
#contrast="$(lord "$dc")"

# if image is dark, make accent lighter. if image is light, make accent darker
#case "$contrast" in 
#	"light") tone=-${delta} ;;
#	"dark") tone=${delta} ;;
#esac

hex=${dc}

initpound=$(echo "$hex" | grep -o '^#')
hex=$( echo "$hex" | cut -d'#' -f2)
amount=${tone}

hextoint() {
	echo "$(( 16#$1 ))"
}
red=$(hextoint "$( echo "$hex" | cut -c1-2 )" )
green=$(hextoint "$( echo "$hex" | cut -c3-4 )" )
blue=$(hextoint "$( echo "$hex" | cut -c5-6 )" )
(( red+=amount ))
(( green+=amount ))
(( blue+=amount ))
if test "$red" -gt 255; then red=255; fi
if test "$green" -gt 255; then green=255; fi
if test "$blue" -gt 255; then blue=255; fi
if test "$red" -lt 0; then red=0; fi
if test "$green" -lt 0; then green=0; fi
if test "$blue" -lt 0; then blue=0; fi
inttohex() {
    printf "%02x\n" "$1"
}
rh=$(inttohex $red)
gh=$(inttohex $green)
bh=$(inttohex $blue)

accentcolor="${initpound}${rh}${gh}${bh}"

# get accentcolor contrast (light or dark)

# contrast="$(lord "$accentcolor")"
# if accentcolor is light, make text black, else make text white
# case "$contrast" in 
# 	"light") textcolor="#111111";;
# 	"dark") textcolor="#eeeeee";;
# esac

if [[ "$#" -eq "1" || "$2" =~ ^(a|all|l|light) ]]; then echo "$dc"; fi
if [[ "$#" -eq "1" || "$2" =~ ^(a|all|d|dark) ]]; then echo "$accentcolor"; fi
# echo "$textcolor"

