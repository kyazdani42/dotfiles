#!/bin/bash

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

if [ ! -d "$HOME/.config/base16-shell" ]
then
	echo "** installing base16-shell colors **"

	if ! git clone https://github.com/chriskempson/base16-shell.git "$HOME/.config/base16-shell" &>/dev/null
	then
		echo "Error installing base16-shell colors, exiting."
		exit 1
	fi

	echo "-- base16-shell colors installed --"
	echo
fi

echo "link zsh configuration file"
rm -f "$HOME"/{.zshrc,.zsh-syntax-highlighting,.oh-my-zsh}
ln -s "$PWD/config/zsh/zshrc" "$HOME/.zshrc"
ln -s "$PWD/config/zsh/zsh-syntax-highlighting" "$HOME/.zsh-syntax-highlighting"
ln -s "$PWD/config/zsh/oh-my-zsh" "$HOME/.oh-my-zsh"
ln -s "$PWD/config/zsh/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

# enable vi key bindings
sed -i 's/bindkey -e/bindkey -v\nexport KEYTIMEOUT=1/g' "$HOME/.oh-my-zsh/lib/key-bindings.zsh"

