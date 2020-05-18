#!/bin/sh

res="$(iwlist wlp2s0 scan | grep ESSID | cut -d':' -f2 | tr -d '"')"

if [ "$res" != "" ]; then
    printf "connected to \`$res\`"
else
    printf "disconnected"
fi
