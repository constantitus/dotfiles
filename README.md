My Dotfiles
=======

*mostly stolen stuff from other r/unixporn users*

----
### Main packages:
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
- brighntessctl (systemd) or dev-libs/light for brightness control.
- lf (terminal file manager)
- lf-ueberzug dependencies from (this)[https://github.com/slavistan/lf-gadgets] repository
	(image preview for lf)(the scripts are already in the dotfiles)

I use pipewire and wireplumber instead of pulseaudio.

----
### xinitrc config
Add 
```bash
setxkbmap us &
sh ~/.config/bspwm/launch.sh &
sh ~/.config/bspwm/pipewire & # pipewire-pulse launch script
sh ~/.config/bspwm/bspwmrc &
exec dbus-launch --exit-with-session bspwm -c /home/bern/.config/bspwm/bspwmrc
```

----
I'm probably missing something...

oh, yea. the background is from "oshi no ko".
