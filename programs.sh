#!/bin/bash

installer="err"

function checkinstaller() {
	command -v "$1" &>/dev/null
}

[ "$(checkinstaller "pacman")" == 0 ] && installer="pacman"

[ "$(checkinstaller "apt-get")" == 0 ] && installer="apt-get install"

[ "$(checkinstaller "apt")" == 0 ] && installer="apt install"

[ "$installer" == "err" ] && echo "Error: no supported package manager found" && exit 1;

echo "Installer with $installer: continue ?: (y/n)"
read -r should_continue
[ "$should_continue" != "y" ] && exit 1;

function installer() {
	program=$1
	[ -n "$2" ] && program=$2
	command -v "$program" &>/dev/null
	if [ $? == 1 ]; then
		echo "installing $1"
		sudo pacman -Sy "$1"
		[ $? == 1 ] && echo "$1 was not installed" >> install-log.error
	fi
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
installer zsh
installer zathura
installer npm
installer yarn
installer chromium
installer firefox
installer pass
installer i3lock
installer xss-lock
installer nautilus

installer nodejs node
installer net-tools ifconfig
installer ripgrep rg
installer neovim nvim

# install fonts
installer ttf-dejavu
installer adobe-source-sans-pro-fonts
fc-cache

