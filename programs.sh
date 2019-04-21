#!/bin/bash

echo installing programs

sudo pacman -S \
	git \
	vim \
	neovim \
	alacritty \
	bat \
	compton \
	exa \
	feh \
	polybar \
	tmux \
	vifm \
	zsh \
	zathura \
	nodejs \
	npm \
	yarn \
	net-tools \
	chromium \
	firefox

exit $?
