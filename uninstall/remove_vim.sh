#!/bin/bash

sudo pacman -Rns vim neovim
rm -rf config/vim/autoload/plug.vim
rm -f ~/.vim ~/.vimrc ~/.viminfo ~/.config/nvim
rm -rf ~/.fzf
