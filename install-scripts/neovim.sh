#!/usr/bin/env bash

set -eo pipefail

NVIM_STORAGE_DIR="$HOME/dev/nvim"
NVIM_CONFIG_DIR="${NVIM_STORAGE_DIR}/config" 

echo "Start neovim configuration"
echo "Clone local repositories"

git clone "git@github.com:kyazdani42/blue-moon" "${NVIM_STORAGE_DIR}/blue-moon"

if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    echo "Installing neovim configurations..."

    TARGET_DIR="$HOME/.config/nvim"
    rm -rf "$TARGET_DIR"
    git clone git@git.sr.ht:~yazdan/nvim-config "$NVIM_CONFIG_DIR" &>/dev/null
    ln -sfv "$NVIM_CONFIG_DIR" "$TARGET_DIR"

    echo "Neovim configurations installed properly"
fi

PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
[ ! -d "$PACKER_DIR" ] && {
  echo "Installing packer.nvim"
  git clone --depth=1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR" &>/dev/null
}

ANISEED_DIR="$HOME/.local/share/nvim/site/pack/packer/start/aniseed"
[ ! -d "$ANISEED_DIR" ] && {
  echo "Installing aniseed"
  git clone --depth=1 https://github.com/Olical/aniseed "$ANISEED_DIR" &>/dev/null
}

echo "Installing final plugins...might take a little while"

nvim --headless +qa
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Neovim was properly configured."
