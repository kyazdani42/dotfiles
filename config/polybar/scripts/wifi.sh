#!/bin/sh

res="$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d':' -f2)"

if [ "$res" != "" ]; then
    printf "connected to \`$res\`"
else
    printf "disconnected"
fi
