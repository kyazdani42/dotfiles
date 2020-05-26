#!/bin/bash

tods=`cat $XDG_DATA_HOME/todo.md`
readarray -t todos <<<"$tods"

idx=$(( $RANDOM % ${#todos[@]} ))
echo ${todos[$idx]} | tr -d '\-*' | sed 's/LOW/low:/' | sed 's/MED/medium: /' | sed 's/HI/high: /'
