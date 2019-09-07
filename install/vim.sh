#!/bin/bash

if ! command -v vim >/dev/null; then
	echo "** installing vim **"
	sudo pacman -Sy --noconfirm vim >/dev/null
	[ "$?" != "0" ] && printf "Error during vim installation, exiting.\n" && exit 1;
	echo "-- vim installed --"
fi

if ! command -v nvim >/dev/null; then
	echo "** installing neovim **"
	sudo pacman -Sy --noconfirm neovim >/dev/null
	[ "$?" != "0" ] && printf "Error during neovim installation, exiting.\n" && exit 1;
	echo "-- neovim installed --"
fi

printf "remove vim config file and folder\n"
rm -f $HOME/{.vim,.vimrc}
rm -f $HOME/.config/nvim

printf "install vim config file and folder\n"
ln -s "$PWD/config/vim" "$HOME/.vim"
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"

# because on a freshly new installed system there is no config folder yet
mkdir -p $HOME/.config
ln -s "$PWD/config/nvim" "$HOME/.config/nvim"

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
	mkdir -p "$HOME/.vim/autoload"

	printf "installing vim plugin manager\n"
	curl -sfLo "$HOME/.vim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" >/dev/null
	echo "vim plug installed"
fi

