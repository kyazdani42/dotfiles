#!/bin/bash

if ! command -v vim >/dev/null; then
	echo "** installing vim **"

	if ! sudo pacman -Sy --noconfirm vim >/dev/null
	then
		echo "Error during vim installation, exiting."
		exit 1
	fi

	echo "-- vim installed --"
	echo
fi

if ! command -v nvim >/dev/null; then
	echo "** installing neovim **"

	if ! sudo pacman -Sy --noconfirm neovim >/dev/null
	then
		echo "Error during neovim installation, exiting."
		exit 1
	fi

	echo "-- neovim installed --"
	echo
fi

echo "remove vim config file and folder"
rm -f "$HOME"/{.vim,.vimrc}
rm -f "$HOME/.config/nvim"

echo "install vim config file and folder"
ln -s "$PWD/config/vim" "$HOME/.vim"
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"

# because on a freshly new installed system there is no config folder yet
mkdir -p "$HOME/.config"
ln -s "$PWD/config/nvim" "$HOME/.config/nvim"

rm -f "$HOME/.vim/autoload/plug.vim"
ln -s "$PWD/config/vim/autoload/plug-vim/plug.vim" "$HOME/.vim/autoload/plug.vim"

