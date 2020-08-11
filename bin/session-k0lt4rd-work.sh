#!/bin/sh

if [ "$(tty)" = "/dev/tty1" ]; then
    exec i3
fi
