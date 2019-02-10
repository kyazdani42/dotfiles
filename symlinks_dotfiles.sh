# link home config file
ln -s .gitconfig $HOME/.gitconfig
ln -s .profile $HOME/.profile
ln -s .xinitrc $HOME/.xinitrc
ln -s .Xresources $HOME/.Xresources
ln -s .zshrc $HOME/.zshrc

# link home scripts
ln -s .scripts $HOME/.scripts

# link vim config
ln -s .vim $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc

# link .config folders
ln -s .config/alacritty $HOME/.config/alacritty
ln -s .config/compton.conf $HOME/.config/compton.conf
ln -s .config/i3 $HOME/.config/i3
ln -s .config/i3blocks $HOME/.config/i3blocks

