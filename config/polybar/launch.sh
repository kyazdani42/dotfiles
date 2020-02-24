#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar -q --reload date &
        MONITOR=$m polybar -q --reload xwindow &
        MONITOR=$m polybar -q --reload i3 &
        MONITOR=$m polybar -q --reload volume_and_controls &
        MONITOR=$m polybar -q --reload mpd &
    done
else
    polybar -q --reload date &
    polybar -q --reload xwindow &
    polybar -q --reload i3 &
    polybar -q --reload volume_and_controls &
    polybar -q --reload mpd &
fi

