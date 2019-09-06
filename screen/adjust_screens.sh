#!/bin/bash

connected_lines=$(xrandr | grep -e " connected [0-9]")
primary_line=$(xrandr | grep -e " connected primary [0-9]")

connected_resolutions=$(echo $connected_lines | grep -oe "[0-9]\{3,4\}x[0-9]\{3,4\}" | sed 's/x/ /')
connected_inches=$(echo $connected_lines | grep -oe "[0-9]\{3,4\}mm x [0-9]\{3,4\}mm" | sed 's/[m,x]/ /g')

primary_resolution=$(echo $primary_line | grep -oe "[0-9]\{3,4\}x[0-9]\{3,4\}" | sed 's/x/ /')
primary_inches=$(echo $primary_line | grep -oe "[0-9]\{3,4\}mm x [0-9]\{3,4\}mm" | sed 's/[m,x]/ /g')

PATH=".:$PATH"
[ -n "$primary_resolution" ] && [ -n "$pimary_inches" ] && compute_res_inch_dpi.py "$primary_resolution" "$primary_inches" && echo
[ -n "$connected_resolutions" ] && [ -n "$connected_inches" ] && compute_res_inch_dpi.py "$connected_resolutions" "$connected_inches"

