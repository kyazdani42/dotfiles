#!/usr/bin/env bash

if [ "$1" == "-h" ]; then
    echo "./install.sh"
    printf "        \e[1m--ignore-install\e[0m        do not install/update packages\n"
    printf "        \e[1m--with-x11\e[0m              installs with x11 instead of wayland\n"
    exit 0
fi

if ! [ "$1" == '--ignore-install' ]; then
    if ! ./install-arch.sh; then exit 1; fi
fi

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

printf "\x1b[1m- Initialize home folders\n"
rm -rf $HOME/Pictures
ln -sf $PWD/Pictures $HOME/pictures
rm -rf $HOME/.local/bin
ln -sf $PWD/bin $HOME/.local/bin
mkdir -p $HOME/{dev,docs,music,.config}
cp Pictures/wall/bonsai.png ~/.config/wallpaper

ln -sf $PWD/zprofile $HOME/.zprofile
ln -sf "alacritty-$(hostname)_$(whoami).yml" $PWD/config/common/alacritty/alacritty.yml

link_files() {
	echo "- Linking $1 configuration files"
	cd config/$1
	for file in *; do
		linkto="$HOME/.config/$file"
		rm -rf $linkto
		linkfrom="$PWD/$file"
		ln -sf $linkfrom $linkto
	done
	cd -
}

link_files "common"

echo "- Linking vimrc"
rm -f $HOME/.vimrc
sudo cp -f $PWD/etc/vimrc /etc/vimrc

if command -v yarn >/dev/null; then
    yarn -s config set prefix "$HOME/.config/yarn" &>/dev/null
fi

if [ "$1" == "--with-x11" ] || [ "$2" == "--with-x11" ]; then
    ln -sfv $PWD/x11/Xresources ~/.Xresources
    ln -sfv $PWD/x11/Xmodmap ~/.Xmodmap
    ln -sfv $PWD/x11/xinitrc ~/.xinitrc
    xrdb -merge $HOME/.Xresources
	link_files "x11"
else
	link_files "wayland"
fi

printf "\x1b[0m\n"

cat <<EOF
Installation is done, you might want to reboot your system
==========================================================
POST INSTALL STEPS:                                        
- run PlugInstall in neovim
- install neovim git projects in ~/dev/nvim_dev
- install gtk theme \`juno palenight\`
- Modify \`~/.icons/index.theme\` or \`/usr/share/icons/default/index.theme\` for setting cursors systemwide
EOF
