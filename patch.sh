#!/bin/bash

VIM_DIR="$PWD/config/vim"

[ ! -d $VIM_DIR ] && echo "folder vim not found" && exit 1;

PT_FILE="$VIM_DIR/plugged/palenight.vim/colors/palenight.vim"

[ ! -f $PT_FILE ] && echo "file palenight.vim not found" && exit 1;

patch $PT_FILE < $VIM_DIR/palenight.patch
