#!/bin/bash

case "$1" in
	"-h" | "--help")
		echo "usage: ./install.sh [-i|--init]"
		exit 0
		;;
	"-i" | "--init")
		if ! ./install/programs.sh; then exit 1; fi
		./install/vim.sh
		./install/shell.sh
		./install/rust.sh
		;;
esac

echo "linking home configuration files"
echo
rm -rf "$HOME"/{.profile,.xinitrc,.Xresources,Pictures,.gtkrc-2.0,.bin}
ln -s "$PWD/config/profile" "$HOME/.profile"
ln -s "$PWD/config/xinitrc" "$HOME/.xinitrc"
ln -s "$PWD/config/Xresources" "$HOME/.Xresources"
ln -s "$PWD/config/gtkrc-2.0" "$HOME/.gtkrc-2.0"
ln -s "$PWD/Pictures" "$HOME/Pictures"
ln -s "$PWD/bin" "$HOME/.bin"

echo "link XDG_CONFIG_HOME configuration files"
rm -rf "$HOME/.config"/{tmux,alacritty,i3,polybar,gtk-3.0}
ln -s "$PWD/config/tmux" "$HOME/.config/tmux"
ln -s "$PWD/config/alacritty" "$HOME/.config/alacritty"
ln -s "$PWD/config/i3" "$HOME/.config/i3"
ln -s "$PWD/config/polybar" "$HOME/.config/polybar"
ln -s "$PWD/config/gtk-3.0" "$HOME/.config/gtk-3.0"

mkdir -p "$HOME"/{.bin,.workbin}

echo "installation is done, you may now use your new system !"

