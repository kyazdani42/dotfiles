#!/bin/bash

echo "updating your system"
sudo pacman -Syu --noconfirm >/dev/null

if ! command -v yay >/dev/null
then
	echo "** installing yay **"

	git clone https://aur.archlinux.org/yay.git &>/dev/null
	cd yay || cd .
	if ! makepkg -si --noconfirm &>/dev/null
	then
		echo "Error during yay installation, exiting"
		exit 1
	fi
	cd - || cd .
	rm -rf yay
	echo "-- yay successfully installed --"
fi

function install() {
	if ! $(command -v "sudo") pacman -Q | grep "$1" >/dev/null
	then
		echo "** installing $1 **"

		if ! yay -Sy --noconfirm "$1" &>/dev/null
		then
			echo "$1 was not installed" >> install-log.error
		else
			echo "-- $1 has been installed --"
		fi
	fi
}

install xorg
install xorg-server
install xorg-xinit
install xorg-xmodmap
install xorg-xev
install xorg-xdpyinfo
install xorg-xrandr
install xdotool
install zsh
install vim
install neovim
install vlc
install i3-gaps
install compton
install tree
install zip
install neofetch
install xmonad
install gimp
install lm_sensors
install lightdm
install lightdm-webkit-theme-litarvan
install imagemagick
install lightdm-webkit2-greeter
install unzip
install wget
install curl
install rxvt-unicode
install rsync
install rofi
install php
install pavucontrol
install nmap
install polybar
install youtube-dl
install feh
install alacritty
install tmux
install pass
install i3lock-color
install go
install ffmpeg
install docker
install cups
install xss-lock
install gnome-screenshot
install visual-studio-code-bin
install bat
install starship
# install procs -- the install is not working anymore
install pastel
install exa
install betterlockscreen
install zathura
install nautilus
install chromium
install firefox
install pulseaudio
install pulseaudio-alsa
install yarn
install npm
install nodejs
install net-tools
install ripgrep

install adobe-source-sans-pro-fonts
install adobe-source-code-pro-fonts
install ttf-dejavu
install ttf-font-awesome
install ttf-font-awesome-4
install ttf-inconsolata
install ttf-monaco
install ttf-opensans
install ttf-roboto-mono
install nerd-fonts-dejavu-complete
install nerd-fonts-source-code-pro
install nerd-fonts-ubuntu-mono

fc-cache >/dev/null

if ! sudo systemctl status lightdm.service | grep active
then
	sudo systemctl enable lightdm.service
fi

echo "installed all programs, check install-error.log to see if some programs have not been installed properly"
