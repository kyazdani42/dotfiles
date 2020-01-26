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

# setup lightdm
post_message=""
if ! sudo systemctl status lightdm.service | grep active >/dev/null
then
    if pacman -Q | grep theme-litarvan >/dev/null; then
        yay -Rns lightm-webkit-theme-litarvan
    fi
    if ! yay -S aur/lightdm-webkit-theme-litarvan; then
        print "\x1b[31mError during litarvan install, quitting\x1b[0m";
        exit 1;
    fi
    sudo systemctl enable lightdm.service
    rm -rf /etc/lightdm
    sudo cp -r lightdm /etc/lightdm
    sudo cp Pictures/tower_violet_blue.jpg $(find /usr/share/lightdm-webkit/themes -name 'background.*')
    user=$USER
    sudo cp Pictures/user.png /var/lib/AccountsService/icons/$user.png

    account_service_file="/var/lib/AccountsService/users/$user"
    if [ -f  $account_service_file ]; then
        sudo -i sed "s/Icon=.*$/Icon=\/var\/lib\/AccountsService\/icons\/$user.png/" $account_service_file
    else
        echo "
[User]
Language=
Session=i3
XSession=i3
Icon=/var/lib/AccountsService/icons/$user.png
SystemAccount=false
" | sudo tee $account_service_file
    fi
    post_message="lightdm has been properly configured, run '# systemctl start lightdm.service' to launch it now"
fi

# setup dunst
notification_daemon_file="/usr/share/dbus-1/services/org.freedesktop.Notifications.service"
if command -v dunst >/dev/null && [ ! -f $notification_daemon_file ]
then
    echo "[D-BUS Service]
    Name=org.freedesktop.Notifications
    Exec=/usr/bin/dunst" | sudo tee $notification_daemon_file
fi

# setup docker
if ! groups | grep docker >/dev/null; then
	sudo groupadd docker >/dev/null
	sudo usermod -aG docker $USER
fi

if ! sudo systemctl status docker | grep active > /dev/null
then
	sudo systemctl enable docker
	sudo systemctl start docker
fi

echo "** - installed all programs, check error.log to see if some programs have not been installed properly - **"

echo $post_message
