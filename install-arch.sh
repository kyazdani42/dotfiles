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

# window manager applications
install xorg
install xorg-server
install xorg-xinit
install xorg-xmodmap
install xorg-xev
install xorg-xdpyinfo
install xorg-xrandr
install xdotool
install i3-gaps
install dunst
install sxhkd
install compton
install xmonad
install lightdm
install lightdm-webkit-theme-litarvan
install lightdm-webkit2-greeter
install rofi
install pavucontrol
install polybar
install gnome-screenshot
install feh
install pass
install pulseaudio
install pulseaudio-alsa
install cups
install simple-shutdown-dialog
# locks
install i3lock-color
install betterlockscreen
install xss-lock
# gtk theme
install la-capitaine-icon-theme
install osx-arc-shadow
install xcursor-osx-elcap
# fonts
install adobe-source-sans-pro-fonts
install adobe-source-code-pro-fonts
install ttf-dejavu
install ttf-font-awesome
install ttf-font-awesome-4
install ttf-inconsolata
install ttf-monaco
install ttf-opensans
install ttf-symbola
install ttf-joypixels
install ttf-roboto-mono
install nerd-fonts-dejavu-complete
install nerd-fonts-source-code-pro
install nerd-fonts-ubuntu-mono
fc-cache >/dev/null

# terminal applications
install zsh
install vim
install neovim
install tree
install zip
install unzip
install neofetch
install lm_sensors
install imagemagick
install wget
install curl
install rsync
install nmap
install youtube-dl
install tmux
install ffmpeg

# dev stuff
install php
install go
install docker
install visual-studio-code-bin
install yarn
install npm
install nodejs
install net-tools

# rust stuff
install bat
install alacritty
install starship
install pastel
install exa
install ripgrep

# GUI applications
install rxvt-unicode
install vlc
install zathura
install nautilus
install chromium
install firefox
install gimp

if ! sudo systemctl status lightdm.service | grep active >/dev/null
then
	sudo systemctl enable lightdm.service
    sudo cp config/lightdm/lightdm.conf /etc/lightdm
    sudo cp config/lightdm/lightdm-webkit2-greeter.conf /etc/lightdm
fi

notification_daemon_file="/usr/share/dbus-1/services/org.freedesktop.Notifications.service"

if command -v dunst >/dev/null && [ ! -f $notification_daemon_file ]
then
	echo "[D-BUS Service]
Name=org.freedesktop.Notifications
Exec=/usr/bin/dunst" | sudo tee $notification_daemon_file
fi

echo "** - installed all programs, check install-error.log to see if some programs have not been installed properly - **"

