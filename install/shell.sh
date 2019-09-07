#!/bin/bash

if ! command -v zsh >/dev/null
then
	echo "** installing zsh **"
	sudo pacman -Sy --noconfirm zsh >/dev/null
	[ "$?" != "0" ] && echo "Error installing zsh, exiting." && exit 1;
	echo "-- zsh installed --"
	echo
fi

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh


if [ ! -d "$HOME/.config/base16-shell" ]
then
	echo "** installing base16-shell colors **"

	git clone https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell" &>/dev/null
	[ "$?" != "0" ] && echo "Error installing base16-shell colors, exiting." && exit 1;

	echo "-- base16-shell colors installed --"
	echo
fi

if [ ! -d "$HOME/.oh-my-zsh" ]
then
	echo "** installing oh my zsh **"

	git clone https://github.com/robbyrussell/oh-my-zsh "$HOME/.oh-my-zsh" &>/dev/null

	[ "$?" != "0" ] && echo "Error installing oh my zsh, exiting." && exit 1;

	# enable vi keybindings
	sed -i 's/bindkey -e/bindkey -v\nexport KEYTIMEOUT=1/g' "$HOME/.oh-my-zsh/lib/key-bindings.zsh"
	echo "-- oh my zsh installed --"
	echo
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
then
	echo "** installing zsh-autosuggestions **"
	git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" &>/dev/null
	[ "$?" != "0" ] && echo "Error installing zsh-autosuggestions, exiting." && exit 1;
	echo "-- zsh-autosuggestions installed --"
	echo
fi

if [ ! -d "$HOME/.zsh-syntax-highlighting" ]
then
	echo "** installing zsh-syntax hilighting **"

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" &>/dev/null

	[ "$?" != "0" ] && echo "Error installing zsh-syntax-highlighting, exiting." && exit 1;
	echo "-- zsh-syntax-highlighting installed --"
	echo
fi

echo "link zsh configuration file"

rm -f "$HOME/.zshrc"
ln -s "$PWD/config/zshrc" "$HOME/.zshrc"

