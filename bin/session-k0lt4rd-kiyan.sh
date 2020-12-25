#!/bin/sh

if [ "$(tty)" = "/dev/tty1" ]; then
	startx &>/tmp/startx.log
fi
