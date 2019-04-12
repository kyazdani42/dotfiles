# link home config file
ln -s $PWD/.gitconfig $HOME/.gitconfig
ln -s $PWD/.profile $HOME/.profile
ln -s $PWD/.xinitrc $HOME/.xinitrc
ln -s $PWD/.Xresources $HOME/.Xresources
ln -s $PWD/.zshrc $HOME/.zshrc

# link home scripts
ln -s $PWD/.scripts $HOME/.scripts

# link vim config
ln -s $PWD/.vim $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc

# link .config folders
ln -s $PWD/.config/alacritty $HOME/.config/alacritty
ln -s $PWD/.config/compton.conf $HOME/.config/compton.conf
ln -s $PWD/.config/i3 $HOME/.config/i3
ln -s $PWD/.config/i3blocks $HOME/.config/i3blocks
ln -s $PWD/.config/polybar $HOME/.config/polybar
