#!/bin/sh

station=$(iwctl station list | grep wl | awk '{print $1}')
res="$(iwctl station $station show | grep 'Connected network' | awk '{print $3}')"

if [ "$res" != "" ]; then
    printf "connected to \`$res\`"
elif ifconfig | egrep "enp.*UP.*,RUNNING" &>/dev/null; then
    printf "connected via ethernet"
else
    printf "disconnected"
fi
