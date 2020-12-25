#!/bin/sh

if [ "$(tty)" = "/dev/tty1" ]; then
    exec startx &>/tmp/startx.log
fi
