#!/bin/bash

if ! ./install-arch.sh; then exit 1; fi

[ "$SHELL" != "/usr/bin/zsh" ] && chsh -s /usr/bin/zsh

mkdir -p "$HOME/.config"

echo "Removing .zshrc, .zsh-syntax-highlighting, .oh-my-zsh"
rm -f "$HOME"/{.zshrc,.zsh-syntax-highlighting,.oh-my-zsh,.zsh_vi_mode}

echo "removing zsh-autosuggestions"
rm -f "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
rm -f "$PWD/config/zsh/oh-my-zsh/custom/plugins/zsh-autosuggestions"

echo "removing base16-shell colors"
rm -f "$HOME/.config/base16-shell"

echo "creating symlink for .zshrc"
ln -s "$PWD/config/zsh/zshrc" "$HOME/.zshrc"

echo "creating symlink for .zsh_vi_mode"
ln -s "$PWD/config/zsh/zsh_vi_mode" "$HOME/.zsh_vi_mode"

echo "creating symlink for .zsh-syntax-highlighting"
ln -s "$PWD/config/zsh/zsh-syntax-highlighting" "$HOME/.zsh-syntax-highlighting"

echo "creating symlink for .oh-my-zsh"
ln -s "$PWD/config/zsh/oh-my-zsh" "$HOME/.oh-my-zsh"

echo "creating symlink for plugin zsh-autosuggestions"
ln -s "$PWD/config/zsh/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

echo "creating symlink for base16-shell colors"
ln -s "$PWD/config/base16-shell" "$HOME/.config/base16-shell"

echo "removing vim config file and folder"
rm -f "$HOME"/{.vim,.vimrc}
rm -f "$HOME/.config/nvim"

echo "creating symlink for vim config file and folder"
ln -s "$PWD/config/vim" "$HOME/.vim"
ln -s "$HOME/.vim/vimrc" "$HOME/.vimrc"

echo "creating symlink for neovim"
ln -s "$PWD/config/nvim" "$HOME/.config/nvim"

echo "removing plug.vim"
rm -f "$HOME/.vim/autoload/plug.vim"

echo "creating symlink for plug.vim"
ln -s "$PWD/config/vim/autoload/plug-vim/plug.vim" "$HOME/.vim/autoload/plug.vim"


echo "remove home configuration file"
rm -rf "$HOME"/{.profile,.xprofile,.xinitrc,.Xmodmap,.Xresources,Pictures,.gtkrc-2.0,.bin}

echo "creating symlink for home configuration files"
ln -s "$PWD/config/profile" "$HOME/.profile"
ln -s "$PWD/config/xinitrc" "$HOME/.xinitrc"
ln -s "$PWD/config/xprofile" "$HOME/.xprofile"
ln -s "$PWD/config/Xresources" "$HOME/.Xresources"
ln -s "$PWD/config/Xmodmap" "$HOME/.Xmodmap"
ln -s "$PWD/config/gtkrc-2.0" "$HOME/.gtkrc-2.0"
ln -s "$PWD/Pictures" "$HOME/Pictures"
ln -s "$PWD/bin" "$HOME/.bin"

echo "removing XFG_CONFIG_HOME configuration files"
rm -rf "$HOME/.config"/{tmux,alacritty,i3,polybar,gtk-3.0,sxhkd,dunst}

echo "link XDG_CONFIG_HOME configuration files"
ln -s "$PWD/config/tmux" "$HOME/.config/tmux"
ln -s "$PWD/config/alacritty" "$HOME/.config/alacritty"
ln -s "$PWD/config/i3" "$HOME/.config/i3"
ln -s "$PWD/config/polybar" "$HOME/.config/polybar"
ln -s "$PWD/config/gtk-3.0" "$HOME/.config/gtk-3.0"
ln -s "$PWD/config/sxhkd" "$HOME/.config/sxhkd"
ln -s "$PWD/config/dunst" "$HOME/.config/dunst"

mkdir -p "$HOME/.workbin"

echo "
*************************************************************
Installation is done, you might want to reboot your system  *
----------------------------------------------------------- *
POST INSTALL STEPS:                                         *
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*
- polybar       : height, font sizes                        *
- dmenu scripts : heights, font sizes                       *
- docker        : configuration to run docker without sudo  *
- vim           : launch PlugInstall, CocInstall            *
- coc           : coc-tsserver coc-prettier coc-json        *
                > coc-css coc-rls coc-html coc-emmet        *
                > coc-styled-components                     *
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*
*************************************************************
"

echo "when launching the system, you may need to adjust the dpi level of each monitor. launching set_dpis should do the trick"

