#!/usr/bin/env bash

capacity_file="/sys/class/power_supply/BAT0/capacity"
status_file="/sys/class/power_supply/BAT0/status"

time=180

almost_low=0
low=0

notif() {
    notify-send -t 5000 -u "$1" "$2" &
}

while sleep $time; do
    status=$(cat $status_file)
    [ "$status" == "Charging" ] && continue;

    cap=$(cat $capacity_file)
    if [ $cap -le 15 ] && [ "$low" == "0" ]; then
        low=1
        almost_low=1
        notif "critical" "LOW_BATTERY"
    elif [ $cap -le 30 ] && [ "$almost_low" == "0" ]; then
        almost_low=1
        notif "normal" "BATTERY < 30 %"
    fi

    if [ "$almost_low" == "1" ] && [ "$low" == "1" ] ; then
        break;
    fi
done
