#!/bin/bash

function installer() {
	which $1 &>/dev/null
	[ $? == 1 ] && echo "installing $1" && sudo pacman -Sy $1
}

installer git
installer vim
installer alacritty
installer bat
installer compton
installer exa
installer feh
installer polybar
installer tmux
installer vifm
installer zsh
installer zathura
installer npm
installer yarn
installer chromium
installer firefox

installer nodejs
installer net-tools
installer ripgrep
installer neovim

exit $?

