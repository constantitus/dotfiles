My Dotfiles
=======

*mostly stolen stuff from other r/unixporn users*

----
### Main packages:
- BSPWM
- Polybar
- SXHKD
- Picom [jonaburg-fix](https://github.com/jonaburg/picom)
- rofi or dmenu for launching apps, both are in the config
- Alacritty or Kitty (or whichever terminal you prefer)
- xsetroot (for the cursor)
- xsettingsd
- wmctrl (for polywins)
### Misc packages:
- zsh
- xinerama (for dual monitor)
- scrot (screenshots)
- redshift (warmer colors during nighttime)
- (uniconize)[https://github.com/neXromancers/uniconize] (solves blackscreen issues in wine)
- brighntessctl (systemd) or dev-libs/light for brightness control.
- kitty (terminal)
- lf (terminal file manager)
- lf-ueberzug dependencies from (this)[https://github.com/slavistan/lf-gadgets] repository
	(image preview for lf)(the scripts are already in the dotfiles)
- gotop

I use pipewire and wireplumber instead of pulseaudio.
If you just use pulseaudio, delete the script for pipewire.

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
