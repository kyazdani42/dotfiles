#!/usr/bin/env bash

[ "$XDG_SESSION_TYPE" == "wayland" ] && makoctl dismiss -a

vol="$(pamixer --get-volume)%"
[ "$(pamixer --get-mute)" == "true" ] && vol="Mute"
notify-send \
    -h string:x-canonical-private-synchronous:anything \
    -t 1000 \
    "volume: $vol"

