#!/bin/bash

function update_system() {
	printf "\e[1mupdating your system\e[0m\nThis might take some time...\n"
	sudo pacman -Syu --noconfirm &>/dev/null
	printf "\e[1;35mDone !\e[0m\n\n"
}

function install_yay() {
	if ! command -v yay >/dev/null
	then
		echo "** installing yay **"

		git clone https://aur.archlinux.org/yay.git &>/dev/null
		cd yay || exit 1
		if ! makepkg -si --noconfirm &>/dev/null
		then
			echo "Error during yay installation, exiting"
			exit 1
		fi
		cd .. || exit 1
		rm -rf yay
		echo "-- yay successfully installed --"
	fi
}

function install() {
	if ! yay -Q | egrep "^$1" >/dev/null
	then
		printf "\r\e[K\x1b[32m** installing $1 **\x1b[0m"

		if ! yay -Sy --noconfirm "$1" &>/dev/null
		then
			printf "\r\e[K\x1b[31m$1 was not installed\x1b[0m\n"
			echo "$1 was not installed" >> error.log
		else
			printf "\r\e[K\x1b[32m-- $1 has been installed --\x1b[0m\n"
		fi
	else
		printf "\r\e[K\x1b[35m$1 has already been installed\x1b[0m"
	fi
}

function install_programs() {
	while read file; do
		install $file
	done <programs.txt
	printf "\r\e[K"

	fc-cache >/dev/null
}

function dmenu_rofi() {
    pushd /usr/bin >/dev/null
    sudo rm -f dmenu >/dev/null
    sudo ln -sf rofi dmenu >/dev/null
    popd >/dev/null
}

function setup_dunst() {
	sudo cp -f etc/notifications.service /usr/share/dbus-1/services/org.freedesktop.Notifications.service
}

function setup_docker() {
	if ! groups | grep docker >/dev/null; then
		sudo groupadd docker >/dev/null
		sudo usermod -aG docker $USER
	fi
}

function enable_service() {
	sudo systemctl enable $1 &>/dev/null
}

function start_service() {
	sudo systemctl start $1 &>/dev/null
}

function enable_docker_service() {
	if ! sudo systemctl status docker >/dev/null
	then
		enable_service docker
		start_service docker
	fi
}

update_system
install_yay
install_programs
setup_dunst
setup_docker
enable_docker_service
dmenu_rofi

printf "\x1b[1m** - installed all programs, check error.log to see if some programs have not been installed properly - **\x1b[0m\n\n"

# TODO: find a fix for that
echo "Some programs might not be installed because of name issue: see \`pacman -Q | grep gdb\`\n"
