#!/usr/bin/env bash

BASE_DIR="$HOME/dev/nvim"
NVIM_CONFIG_DIR="${BASE_DIR}/config" 
NVIM_PLUGIN_DIR="${BASE_DIR}/plugins" 

mkdir -p "$NVIM_PLUGIN_DIR"

nvim_plugs=("blue-moon" "nvim-tree.lua" "nvim-treesitter" "nvim-web-devicons")
for repo_name in ${nvim_plugs[@]}; do
    REPO_DIR="${NVIM_PLUGIN_DIR}/${repo_name}"
    [ ! -d "$REPO_DIR" ] && git clone "git@github.com:kyazdani42/${repo_name}" "$REPO_DIR"
done

if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    echo "Installing neovim configurations..."
    git clone git@github.com:kyazdani42/nvim-config "$NVIM_CONFIG_DIR"
    ln -sfv "$NVIM_CONFIG_DIR" "$HOME/.config/nvim"
    echo "Neovim configurations installed properly"
fi

PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
[ ! -d "$PACKER_DIR" ] && git clone --depth=1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"

ANISEED_DIR="$HOME/.local/share/nvim/site/pack/packer/start/aniseed"
[ ! -d "$ANISEED_DIR" ] && git clone --depth=1 https://github.com/Olical/aniseed "$ANISEED_DIR"
