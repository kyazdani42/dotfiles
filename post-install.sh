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

link_files() {
    print_bold "- linking $1 configuration files"

	cd config/$1
	for file in *; do
		linkto="$HOME/.config/$file"
		rm -rf $linkto
		linkfrom="$PWD/$file"
		ln -sf $linkfrom $linkto
	done
	cd - >/dev/null
}

link_files "common"

packer="$HOME/.local/share/nvim/site/pack/packer/opt/packer.nvim"
[ ! -d "$packer" ] && git clone https://github.com/wbthomason/packer.nvim "$packer"

nvim_config="$HOME/dev/nvim-config" 
if [ ! -d "$nvim_config" ]; then
    echo "Cloning config and linking"
    pushd "$HOME/dev/" &>/dev/null
    git clone git@github.com:kyazdani42/nvim-config
    ln -sf "$nvim_config" "$HOME/.config/nvim"
    popd &>/dev/null
fi

nvim_plugs=("blue-moon" "nvim-tree.lua" "nvim-treesitter" "nvim-web-devicons" "playground")
for repo in ${nvim_plugs[@]}; do
    folder="$HOME/dev/plugins/${repo}"
    [ ! -d "$folder" ] && git clone "git@github.com:kyazdani42/${repo}" "$folder"
done

print_bold "select a graphic environment:"

select graphics in x11 wayland
do
    if [ "$graphics" == "x11" ]; then
        cp $PWD/x11/Xresources.tpl $PWD/x11/Xresources
        ln -sfv $PWD/x11/Xresources ~/.Xresources
        ln -sfv $PWD/x11/Xmodmap ~/.Xmodmap
        ln -sfv $PWD/x11/xinitrc ~/.xinitrc
        xrdb -merge $HOME/.Xresources
        link_files "x11"
        break
    elif [ "$graphics" == "wayland" ]; then
        link_files "wayland"
        break
    fi
done

session_file="bin/session-$(hostname)-$(whoami).sh"
if [ ! -f "$session_file" ]; then
    print_bold "select a graphic environment to setup session runner:"

    if [ "$graphics" == "x11" ]; then
        printf "#!/bin/sh\nif [ \"\$(tty)\" = \"/dev/tty1\" ]; then\n\texec startx &>/tmp/startx_\$(whoami).log\nfi\n" > "$session_file"
        chmod +x "$session_file"
    elif [ "$graphics" == "wayland" ]; then
        printf "#!/bin/sh\nexport MOZ_ENABLE_WAYLAND=1\nexport QT_QPA_PLATFORM=wayland-egl\nexport CLUTTER_BACKEND=wayland\nexport XDG_CURRENT_DESKTOP=sway\nexport XDG_SESSION_TYPE=wayland\nif [ \"\$(tty)\" = \"/dev/tty1\" ]; then\n\texec sway &>/tmp/sway.log\nfi\n" > "$session_file"
        chmod +x "$session_file"
    fi
fi

alacritty_config="config/common/alacritty/alacritty.yml"
if [ ! -f "$alacritty_config" ]; then
    cp "config/common/alacritty/config-base.yml" "$alacritty_config"
fi

nwgbar_conf="config/common/nwg-launchers/nwgbar/bar.json"
if [ ! -f "$nwgbar_conf" ]; then
    cp "config/common/nwg-launchers/nwgbar/bar.tpl" "$nwgbar_conf"
    sed -i "s/\\$\\$/$(whoami)/g" "$nwgbar_conf";
fi

polybar_conf="config/x11/polybar/config"
if [ ! -f "$polybar_conf" ]; then
    cp "config/x11/polybar/config.tpl" "$polybar_conf"
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
Installation is done, you might want to reboot your system
==========================================================
POST INSTALL STEPS:                                        
- run PackerInstall and PackerCompile in neovim
- install gtk theme \`juno palenight\`
- Modify \`~/.icons/index.theme\` or \`/usr/share/icons/default/index.theme\` for setting cursors systemwide
EOF
