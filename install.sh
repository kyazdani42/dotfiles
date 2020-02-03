#!/bin/bash

if ! ./install-arch.sh; then exit 1; fi

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

printf "\x1b[1m- Initialize home folders\n"
rm -rf $HOME/{Pictures,.xinit}
ln -s $PWD/xinit $HOME/.xinit
ln -s $PWD/Pictures $HOME/Pictures
rm -rf $HOME/.local/bin
ln -sf $PWD/bin $HOME/.local/bin
mkdir -p $HOME/.config
cp Pictures/mountain_deer.jpg ~/.config/wallpaper

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
xrdb -merge ~/.xinit/Xresources

printf "\x1b[0m\n"

cat <<EOF
Installation is done, you might want to reboot your system
==========================================================
POST INSTALL STEPS:                                        
- run PlugInstall in neovim
- When launching the system, you may need to adjust the dpi level 
  of each monitor, launching set_dpis should do the trick
- Modify font sizes in:
  - alacritty/alacritty.yml
  - polybar/config
  - rofi/config.rasi
  - xinit/Xresources
EOF

