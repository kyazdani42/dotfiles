#!/bin/bash

if ! command -v zsh; then
	sudo pacman -Sy --noconfirm zsh >/dev/null
	[ "$?" != "0" ] && printf "Error installing zsh, exiting.\n" && exit 1;
fi

if [ ! -d "$HOME/.config/base16-shell" ]; then
	printf "installing base16-shell colors"

	git clone https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell" >/dev/null
	[ "?" != "0" ] && printf "Error installing base16-shell colors, exiting.\n" && exit 1;
	printf "base16-shell colors installed\n"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	printf "installing oh my zsh\n"

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh >/dev/null)"

	[ ! -d "$HOME/.oh-my-zsh" ] && printf "Error installing oh my zsh, exiting\n" && exit 1;

	# enable vi keybindings
	sed -i 's/bindkey -e/bindkey -v\nexport KEYTIMEOUT=1/g' "$HOME/.oh-my-zsh/lib/key-bindings.zsh"
	printf "oh my zsh installed\n"

	printf "installing zsh-autosuggestions\n"
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" >/dev/null
	[ "$?" != "0" ] && printf "Error installing zsh-autosuggestions, exiting.\n" && exit 1;
	printf "zsh-autosuggestions installed\n"

	printf "installing zsh-syntax hilighting\n"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting"
	[ "$?" != "0" ] && printf "Error installing zsh-syntax-highlighting, exiting.\n" && exit 1;
fi

printf "link zsh configuration files"

rm "$HOME/.zshrc"
ln -s "$PWD/config/zshrc" "$HOME/.zshrc"


