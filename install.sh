#!/bin/bash

case "$1" in
	"-h" | "--help")
		echo "usage: ./install.sh (--init will try to install programs with your package manager)";
		exit 0;
		;;
	"-i" | "--init")
		./install/programs.sh;
		;;
	"*")
		;;
esac

./install/rust.sh
./install/shell.sh
./install/vim.sh

printf "linking home configuration files\n"

rm -r "$HOME/{.profile,.xinitrc,.Xresources,Pictures,.gtkrc-2.0,.bin}"

ln -s "$PWD/config/profile" "$HOME/.profile"
ln -s "$PWD/config/xinitrc" "$HOME/.xinitrc"
ln -s "$PWD/config/Xresources" "$HOME/.Xresources"
ln -s "$PWD/config/gtkrc-2.0" "$HOME/.gtkrc-2.0"
ln -s "$PWD/Pictures" "$HOME/Pictures"
ln -s "$PWD/bin" "$HOME/.bin"

printf "link XDG_CONFIG_HOME configuration files\n"

rm -rf "$HOME/.config/{nvim,alacritty,compton.conf,i3,i3blocks,polybar,tmux,gtk-3.0}"

ln -s "$PWD/config/tmux" "$HOME/.config/tmux"
ln -s "$PWD/config/alacritty" "$HOME/.config/alacritty"
ln -s "$PWD/config/compton.conf" "$HOME/.config/compton.conf"
ln -s "$PWD/config/i3" "$HOME/.config/i3"
ln -s "$PWD/config/polybar" "$HOME/.config/polybar"
ln -s "$PWD/config/gtk-3.0" "$HOME/.config/gtk-3.0"

