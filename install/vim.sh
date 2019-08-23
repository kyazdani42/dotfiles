#!/bin/bash

if ! command -v vim; then
	sudo pacman -Sy --noconfirm vim >/dev/null
	[ "$?" == "1" ] && printf "Error during vim installation, exiting.\n" && exit 1;
fi

if ! command -v nvim; then
	sudo pacman -Sy --noconfirm neovim >/dev/null
	[ "$?" == "1" ] && printf "Error during neovim installation, exiting.\n" && exit 1;
fi

printf "remove vim config file and folder\n"
rm -rf "$HOME/{.vim,.vimrc}"

printf "link vim config file and folder\n"
ln -s "$PWD/config/vim" "$HOME/.vim"
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"
ln -s "$PWD/config/nvim" "$HOME/.config/nvim"

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
	mkdir -p "$HOME/.vim/autoload"

	printf "installing vim plugin manager\n"
	curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	echo "vim plug installed"
fi

