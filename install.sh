#!/bin/bash

if ! ./install-arch.sh; then exit 1; fi

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

printf "\x1b[1m- Initialize home folders\n"
rm -rf $HOME/Pictures
ln -s $PWD/Pictures $HOME/Pictures
rm -rf $HOME/.local/bin
ln -sf $PWD/bin $HOME/.local/bin
mkdir -p $HOME/.config
cp Pictures/mountain_deer.jpg ~/.config/wallpaper

echo "- Linking X startup scripts"
ln -sf $PWD/xinit/Xresources $HOME/.Xresources
ln -sf $PWD/xinit/profile $HOME/.profile
ln -sf $PWD/xinit/profile $HOME/.zprofile
ln -sf $PWD/xinit/xinitrc $HOME/.xinitrc
ln -sf $PWD/xinit/Xmodmap $HOME/.Xmodmap

echo "- Linking \$XDG_CONFIG_HOME configuration files"
for file in config/*; do
    linkto="$HOME/.$file"
    rm -rf $linkto
    linkfrom="$PWD/$file"
    ln -sf $linkfrom $linkto
done

echo "- Linking vimrc"
rm -f $HOME/.vimrc
ln -sf $PWD/etc/vimrc $HOME/.vimrc
sudo cp -f etc/vimrc /etc/vimrc

if command -v yarn >/dev/null; then
    yarn -s config set prefix "$HOME/.config/yarn" &>/dev/null
fi
nvim +PlugInstall +qa &>/dev/null
nvim +PlugUpdate +qa &>/dev/null
xrdb -merge ~/.Xresources

./bin/select_template xps

printf "\x1b[0m\n"

cat <<EOF
Installation is done, you might want to reboot your system
==========================================================
POST INSTALL STEPS:                                        
Templates:
- copy a folder in the templates folder
- modify config files (font sizes, dpi level, width/heights)
- run \`select_template YOUR_TEMPLATE\`

Gtk:
- install gtk cursor theme \`volantes cursors\`
- install gtk theme \`juno palenight\`
- install gtk icon theme \`la capitaine\`
You can choose other themes but you'll need to change gtkrc configurations and xresources
You might need to modify \`~/.icons/index.theme\` or \`/usr/share/icons/default/index.theme\` for setting cursors systemwide
EOF

