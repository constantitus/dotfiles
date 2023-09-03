My Dotfiles
=======
*mostly stolen stuff from other r/unixporn users*

----
### Dependencies:
- BSPWM
- Polybar
- SXHKD
- Picom (I am using [pijulius](https://github.com/pijulius/picom)' version, for the cool animations)
- rofi or dmenu for launching apps, both are in the config
- Alacritty or Kitty (or whichever terminal you prefer)
- xsetroot (for the cursor)
- xsettingsd
- wmctrl (for polywins)
### Misc packages:
- zsh
- xinerama (for multiple monitors)
- scrot (screenshots)
- redshift (warmer colors during nighttime)
- (uniconize)[https://github.com/neXromancers/uniconize] (solves blackscreen issues in wine)
- lf (terminal file manager)
- lf-ueberzug dependencies from (this)[https://github.com/slavistan/lf-gadgets] repository
	(image preview for lf)(the scripts are already in the dotfiles)
- dunst or something that supports notify-send (to get feedback from the scripts)
### Other stuff
- neovim and vscodium
- sayonara (qt based music player)
- qt5ct-svg-translucent from AUR (qt theme transparency)
- discord-screenaudio (only with pipewire)

I use pipewire with wireplumber instead of pulseaudio.

----
### .xinitrc config
Add 
```bash
setxkbmap us &
sh ~/.config/bspwm/bin/launch.sh &
sh ~/.config/bspwm/bin/pipewire.sh & # pipewire-pulse launch script
sh ~/.config/bspwm/bspwmrc &
sh ~/.config/bspwm/bin/bicom.sh &
exec dbus-launch --exit-with-session bspwm -c /home/bern/.config/bspwm/bspwmrc
```

----
