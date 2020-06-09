#!/bin/sh

xmodmap "$HOME/.Xmodmap"
xrdb -merge "$HOME/.Xresources"

systemctl --user import-environment DISPLAY XAUTHORITY

xset r rate 300 40 &                # Set writing rate
nm-applet &                         # Wifi tray
sxhkd &                             # Launch key bindings
mpd &                               # Music daemon
setbg &                             # Sets the background
unclutter &                         # Hides the cursor
picom -b &  # Compositor
notify_battery_level &              # script to notify when level is too low
polybar_launch.sh &   # bar

exec i3
