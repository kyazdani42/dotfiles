#!/bin/bash

if ! ./install-arch.sh; then exit 1; fi

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

echo "home folders"
rm -rf $HOME/{Pictures,.xinit}
ln -s $PWD/xinit $HOME/.xinit
ln -s $PWD/Pictures $HOME/Pictures

rm -rf $HOME/.local/bin
ln -sf $PWD/bin $HOME/.local/bin
mkdir -p $HOME/.workbin

mkdir -p $HOME/.config

echo "removing XFG_CONFIG_HOME configuration files"
rm -rf $HOME/.config/{gtkrc-2.0,tmux,alacritty,i3,polybar,gtk-3.0,sxhkd,dunst,rofi}

echo "link XDG_CONFIG_HOME configuration files"
for file in config/*; do
    linkto="$HOME/.$file"
    rm -rf $linkto
    linkfrom="$PWD/$file"
    ln -sf $linkfrom $linkto
done

echo "creating symlink for vim config file"
rm $HOME/.vimrc
ln -s $HOME/.vim/vimrc $HOME/.vimrc

if command -v yarn >/dev/null; then
    yarn config set prefix "$HOME/.config/yarn"
fi

xrdb -merge ~/.xinit/Xresources

cat <<EOF
Installation is done, you might want to reboot your system
==========================================================
POST INSTALL STEPS:                                        
- run PlugInstall in vim/neovim
- When launching the system, you may need to adjust the dpi level 
  of each monitor, launching set_dpis should do the trick
- Modify font sizes in:
  - alacritty/alacritty.yml
  - polybar/config
  - rofi/config.rasi
  - xinit/Xresources
EOF

