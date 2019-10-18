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
        printf "\x1b[32m** installing $1 **\x1b[0m\n"

        if ! yay -Sy --noconfirm "$1" &>/dev/null
        then
            printf "\x1b[31m$1 was not installed\x1b[0m\n"
            echo "$1 was not installed" >> error.log
        else
            printf "\x1b[32m-- $1 has been installed --\x1b[0m\n"
        fi
    else
        printf "\x1b[35m$1 has already been installed\x1b[0m\n"
    fi
}

while read file; do
    install $file
done <programs.txt

fc-cache >/dev/null

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

echo "** - installed all programs, check error.log to see if some programs have not been installed properly - **"

