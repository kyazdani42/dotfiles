#!/bin/bash

tods=`cat $XDG_DATA_HOME/todo.md`
readarray -t todos <<<"$tods"

while [ -z "$todo" ] || echo $todo | grep 'LOW' &>/dev/null; do
    idx=$(( $RANDOM % ${#todos[@]} ))
    todo=${todos[$idx]}
done

echo $todo | tr -d '\-*' | sed 's/MED/medium: /' | sed 's/HI/high: /'
