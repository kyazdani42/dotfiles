#!/bin/bash

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

echo "Removing .zshrc, .zsh-syntax-highlighting, .oh-my-zsh"
rm -f "$HOME"/{.zshrc,.zsh-syntax-highlighting,.oh-my-zsh}
echo

echo "removing zsh-autosuggestions"
rm -f "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
rm -f "$PWD/config/zsh/oh-my-zsh/custom/plugins/zsh-autosuggestions"
echo

echo "removing base16-shell colors"
rm -f "$HOME/.config/base16-shell"
echo

echo "creating symlink for .zshrc"
ln -s "$PWD/config/zsh/zshrc" "$HOME/.zshrc"
echo

echo "creating symlink for .zsh-syntax-highlighting"
ln -s "$PWD/config/zsh/zsh-syntax-highlighting" "$HOME/.zsh-syntax-highlighting"
echo

echo "creating symlink for .oh-my-zsh"
ln -s "$PWD/config/zsh/oh-my-zsh" "$HOME/.oh-my-zsh"
echo

echo "changing zsh emacs key bindings to vi key bindings"
sed -i 's/bindkey -e/bindkey -v\nexport KEYTIMEOUT=1/g' "$HOME/.oh-my-zsh/lib/key-bindings.zsh"
echo

echo "creating symlink for plugin zsh-autosuggestions"
ln -s "$PWD/config/zsh/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
echo

echo "creating symlink for base16-shell colors"
ln -s "$PWD/config/base16-shell" "$HOME/.config/base16-shell"
echo

