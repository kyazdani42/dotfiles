#!/usr/bin/env bash

if ! ./install-arch.sh; then exit 1; fi

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

printf "\x1b[1m- Initialize home folders\n"
rm -rf $HOME/Pictures
ln -s $PWD/Pictures $HOME/pictures
rm -rf $HOME/.local/bin
ln -sf $PWD/bin $HOME/.local/bin
mkdir -p $HOME/{dev,docs,music,.config}
cp Pictures/wall/bonsai.png ~/.config/wallpaper

ln -sf $PWD/zprofile $HOME/.zprofile
ln -sf "alacritty-$(cat /etc/hostname).yml" $PWD/config/alacritty/alacritty.yml

echo "- Linking \$XDG_CONFIG_HOME configuration files"
for file in config/*; do
    linkto="$HOME/.$file"
    rm -rf $linkto
    linkfrom="$PWD/$file"
    ln -sf $linkfrom $linkto
done

echo "- Linking vimrc"
rm -f $HOME/.vimrc
sudo cp -f $PWD/etc/vimrc /etc/vimrc

if command -v yarn >/dev/null; then
    yarn -s config set prefix "$HOME/.config/yarn" &>/dev/null
fi

nvim +PlugInstall +qa &>/dev/null &
xrdb -merge $HOME/.Xresources

printf "\x1b[0m\n"

cat <<EOF
Installation is done, you might want to reboot your system
==========================================================
POST INSTALL STEPS:                                        
- install neovim git projects in ~/dev/nvim_dev
- install gtk theme \`juno palenight\`
- Modify \`~/.icons/index.theme\` or \`/usr/share/icons/default/index.theme\` for setting cursors systemwide
EOF

