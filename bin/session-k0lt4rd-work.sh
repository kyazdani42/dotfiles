#!/bin/sh

export BROWSER="google-chrome-stable"

if [ "$(tty)" = "/dev/tty1" ]; then
    exec startx 2>&1 1>/tmp/startx.log
fi
