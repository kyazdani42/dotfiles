#!/usr/bin/env bash

set -euo pipefail

print_bold() {
    printf "\x1b[1m$1\x1b[0m\n"
}

print_bold "- initialize home folders"

rm -rf $HOME/{P,p}ictures
ln -sfv $PWD/Pictures $HOME/pictures
rm -rf $HOME/.local/bin
ln -sfv $PWD/bin $HOME/.local/bin
mkdir -p $HOME/{dev,docs,music,videos,.config}
cp Pictures/wall/samurai_river.jpg ~/.config/wallpaper

ln -sf $PWD/zprofile $HOME/.zprofile

print_bold "- linking configuration files"

cd config
for file in *; do
    linkto="$HOME/.config/$file"
    rm -rf $linkto
    linkfrom="$PWD/$file"
    ln -sf $linkfrom $linkto
done
cd - >/dev/null

packer="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
[ ! -d "$packer" ] && git clone https://github.com/wbthomason/packer.nvim "$packer"

mkdir -p "$HOME/dev/nvim/plugins"

nvim_config="$HOME/dev/nvim/config" 
if [ ! -d "$nvim_config" ]; then
    echo "Cloning config and linking"
    git clone git@github.com:kyazdani42/nvim-config "$nvim_config"
    ln -sf "$nvim_config" "$HOME/.config/nvim"
fi

nvim_plugs=("blue-moon" "nvim-tree.lua" "nvim-treesitter" "nvim-web-devicons")
for repo in ${nvim_plugs[@]}; do
    folder="$HOME/dev/nvim/plugins/${repo}"
    [ ! -d "$folder" ] && git clone "git@github.com:kyazdani42/${repo}" "$folder"
done

session_file="bin/session-$(hostname)-$(whoami).sh"
if [ ! -f "$session_file" ]; then
    cp session-template.sh "$session_file"
    chmod +x "$session_file"
fi

alacritty_config="config/alacritty/alacritty.yml"
if [ ! -f "$alacritty_config" ]; then
    cp "config/alacritty/config-base.yml" "$alacritty_config"
fi

nwgbar_conf="config/nwg-launchers/nwgbar/bar.json"
if [ ! -f "$nwgbar_conf" ]; then
    cp "config/nwg-launchers/nwgbar/bar.template.json" "$nwgbar_conf"
    sed -i "s/\\$\\$/$(whoami)/g" "$nwgbar_conf";
fi

if command -v yarn >/dev/null; then
    function yarn_path_config() {
        yarn -s --use-yarnrc "$HOME/.config/yarn/config" \
            config set $1 "$HOME/.config/yarn" &>/dev/null
    }
    yarn_path_config prefix
    yarn_path_config global-folder
fi


cat <<EOF
Installation is done, you should restart your session
==========================================================
POST INSTALL STEPS:                                        
- run PackerInstall and PackerCompile in neovim
- Set GTK theme in gtk 2, 3 and 4
- Set cursors for wayland + gtk
EOF
