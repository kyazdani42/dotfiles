#!/bin/sh

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland-egl
export CLUTTER_BACKEND=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

if [ "$(tty)" = "/dev/tty1" ]; then
    exec sway &>/tmp/sway.log
fi
