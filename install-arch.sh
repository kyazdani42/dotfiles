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


function check_service() {
	sudo systemctl status $1 > /dev/null;
	return $?
}

function enable_service() {
	sudo systemctl enable $1 &>/dev/null
}

function start_service() {
	sudo systemctl start $1 &>/dev/null
}

function setup_lightdm() {
	if ! check_service lightdm
	then
		enable_service lightdm
		sudo rm -rf /etc/lightdm; sudo cp -fr etc/lightdm /etc/lightdm
		sudo cp Pictures/tower_violet_blue.jpg $(find /usr/share/lightdm-webkit/themes -name 'background.*')
		sudo cp Pictures/user.png /var/lib/AccountsService/icons/$USER.png
		echo "[User]
Session=i3
XSession=i3
Icon=/var/lib/AccountsService/icons/$USER.png
SystemAccount=false" | sudo tee /var/lib/AccountsService/users/$USER &>/dev/null
	fi
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

function enable_docker_service() {
	if ! check_service docker
	then
		enable_service docker
		start_service docker
	fi
}

update_system
install_yay
install_programs
setup_lightdm
setup_dunst
setup_docker
enable_docker_service

printf "\x1b[1m** - installed all programs, check error.log to see if some programs have not been installed properly - **\x1b[0m\n\n"

# TODO: find a fix for that
echo "Some programs might not be installed because of name issue: see \`pacman -Q | grep gdb\`\n"
