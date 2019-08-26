#!/bin/bash

function installer() {
	program=$1
	[ -n "$2" ] && program=$2

	if [ ! "$(command -v "$program")" ]; then
		echo "installing $1..."
		$(command -v "sudo") pacman -Sy --noconfirm "$1" >/dev/null
		[ "$?" != "0" ] && echo "$1 was not installed" >> install-log.error
	fi
}

installer git
installer alacritty
installer bat
installer compton
installer exa
installer feh
installer polybar
installer tmux
installer zathura
installer npm
installer yarn
installer chromium
installer firefox
installer pass
installer i3lock
installer xss-lock
installer nautilus
installer gnome-screenshot

installer nodejs node
installer net-tools ifconfig
installer ripgrep rg
installer neovim nvim

# install fonts
installer ttf-dejavu
installer adobe-source-sans-pro-fonts
fc-cache

