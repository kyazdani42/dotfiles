#!/bin/sh

export BROWSER="google-chrome-stable"

if [ "$(tty)" = "/dev/tty1" ]; then
    exec startx >/tmp/startx.log
fi
