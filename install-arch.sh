#!/usr/bin/env bash

update_system() {
	printf "\e[1mupdating your system\e[0m\nThis might take some time...\n"
	sudo pacman -Syu --noconfirm &>/dev/null
	printf "\e[1;35mDone !\e[0m\n\n"
}

install_yay() {
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

install_programs() {
    sudo printf "\e[1mInstalling packages\e[0m\n"
    yay -Sy --noconfirm --needed $(cat pkgs) &>/dev/null &
    while [ "$(jobs | grep -i 'running')" ]; do
        printf "\r\e[K\e[33;1m.\e[0m"
        sleep 0.4;
        printf "\r\e[K\e[33;1m.\e[32m.\e[0m"
        sleep 0.4;
        printf "\r\e[K\e[33;1m.\e[32m.\e[35m.\e[0m"
        sleep 0.4;
    done
    printf "\n\n"
}

setup_docker() {
	if ! groups | grep docker >/dev/null; then
		sudo groupadd docker >/dev/null
		sudo usermod -aG docker $USER
	fi
}

enable_service() {
	sudo systemctl enable $1 &>/dev/null
}

start_service() {
	sudo systemctl start $1 &>/dev/null
}

enable_docker_service() {
	if ! sudo systemctl status docker >/dev/null
	then
		enable_service docker
		start_service docker
	fi
}

update_system
install_yay
install_programs
setup_docker
enable_docker_service
dmenu_rofi

printf "\x1b[1m** - installed all programs, check error.log to see if some programs have not been installed properly - **\x1b[0m\n\n"
