#!/usr/bin/env bash

read -p "install system files and packages ? y/n: " system_install

if [ "$system_install" == "y" ]; then
    if ! ./install-arch.sh; then
        echo "something went wrong during install, please rerun the installer after checking the error log"
        exit 1;
    fi
fi

print_bold() {
    printf "\x1b[1m$1\x1b[0m\n"
}

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

print_bold "- initialize home folders"

rm -rf $HOME/Pictures
ln -sf $PWD/Pictures $HOME/pictures
rm -rf $HOME/.local/bin
ln -sf $PWD/bin $HOME/.local/bin
mkdir -p $HOME/{dev,docs,music,videos,.config}
cp Pictures/wall/bonsai.png ~/.config/wallpaper

ln -sf $PWD/zprofile $HOME/.zprofile
ln -sf "alacritty-$(hostname)_$(whoami).yml" $PWD/config/common/alacritty/alacritty.yml

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

nvim_plugs=("blue-moon" "nvim-tree.lua" "nvim-treesitter" "nvim-web-devicons" "playground")
for repo in ${nvim_plugs[@]}; do
    folder="$HOME/dev/plugins/${repo}"
    [ ! -d "$folder" ] && git clone "git@github.com:kyazdani/${repo}" "$folder"
done

print_bold "- linking vimrc"

rm -f $HOME/.vimrc
sudo cp -f $PWD/etc/vimrc /etc/vimrc

if command -v yarn >/dev/null; then
    yarn -s config set prefix "$HOME/.config/yarn" &>/dev/null
fi

print_bold "select a graphic environment:"

select graphics in x11 wayland
do
    if [ "$graphics" == "x11" ]; then
        ln -sfv $PWD/x11/Xresources ~/.Xresources
        ln -sfv $PWD/x11/Xmodmap ~/.Xmodmap
        ln -sfv $PWD/x11/xinitrc ~/.xinitrc
        xrdb -merge $HOME/.Xresources
        link_files "x11"
    elif [ "$graphics" == "wayland" ]; then
        link_files "wayland"
    fi

    break
done

cat <<EOF
Installation is done, you might want to reboot your system
==========================================================
POST INSTALL STEPS:                                        
- run PackerInstall and PackerCompile in neovim
- install gtk theme \`juno palenight\`
- Modify \`~/.icons/index.theme\` or \`/usr/share/icons/default/index.theme\` for setting cursors systemwide
EOF
