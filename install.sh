#!/bin/bash

if ! ./install-arch.sh; then exit 1; fi

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

echo "home folders"
rm -rf "$HOME"/{Pictures,.bin,.xinit}
ln -s "$PWD/xinit" "$HOME/.xinit"
ln -s "$PWD/Pictures" "$HOME/Pictures"
ln -s "$PWD/bin" "$HOME/.bin"

mkdir -p "$HOME/.config"

echo "removing XFG_CONFIG_HOME configuration files"
rm -rf "$HOME/.config"/{gtkrc-2.0,tmux,alacritty,i3,polybar,gtk-3.0,sxhkd,dunst,rofi}

echo "link XDG_CONFIG_HOME configuration files"
for file in config/*; do
    linkto="$HOME/.$file"
    rm -rf $linkto
    linkfrom="$PWD/$file"
    ln -s $linkfrom $linkto
done

echo "creating symlink for vim config file"
rm "$HOME/.vimrc"
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"

if command -v yarn &>/dev/null; then
    yarn config set prefix "$HOME/.config/yarn"
fi

echo "link emacs config"
ln -sf "$PWD/emacs/init.el" "$HOME/.emacs.d/init.el"

mkdir -p "$HOME/.workbin"

cat <<EOF
*************************************************************
Installation is done, you might want to reboot your system  *
----------------------------------------------------------- *
POST INSTALL STEPS:                                         *
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*
- docker        : configuration to run docker without sudo  *
- vim           : launch PlugInstall, CocInstall            *
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*
*************************************************************

Modify font sizes in alacritty/alacritty.yml, polybar/config rofi/config.rasi xinit/Xresources

rescale firefox in about:config devPixel...,
firefox palenight theme,
firefox tabs on bottom https://github.com/jonhoo/configs/blob/master/gui/.mozilla/firefox/dev-edition-default/chrome/userChrome.css

when launching the system, you may need to adjust the dpi level of each monitor, 
launching set_dpis should do the trick
EOF

