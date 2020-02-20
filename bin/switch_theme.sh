#!/bin/bash

[ -d "$HOME/dotfiles/themes" ] && pushd "$HOME/dotfiles/themes" 1> /dev/null
[ -d "$HOME/.dotfiles/themes" ] && pushd "$HOME/.dotfiles/themes" 1> /dev/null

theme_list=()
symlink_list=()

for file in $(ls); do
    if [ -d "$PWD/$file" ]; then
        theme_list+=("$file")
    else # its a symlink
        symlink_list+=("$file")
    fi
done

select theme in ${theme_list[@]}; do
    for file in ${symlink_list[@]}; do
        ln -sf "$theme/$file" "$file"
    done

    xrdb -merge ~/.xinit/Xresources

    printf "\e[032mYou are now using the \e[1m$theme\e[0;32m theme !\e[0m\n"

    break
done

popd 2>&1 1> /dev/null
