#!/bin/sh

res="$(nmcli device status | grep wlp | grep ' connected' | awk '{print $4}')"

if [ "$res" != "" ]; then
    printf "connected to \`$res\`"
else
    printf "disconnected"
fi
