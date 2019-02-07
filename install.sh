# making links
ln -sf $(pwd)/.scripts $HOME/.scripts
ln -sf $(pwd)/.config $HOME/.config
ln -sf $(pwd)/.vim/vimrc $HOME/.vimrc
ln -sf $(pwd)/.gitconfig $HOME/.gitconfig
ln -sf $(pwd)/.profile $HOME/.profile
ln -sf $(pwd)/.vim $HOME/.vim
ln -sf $(pwd)/.xinitrc $HOME/.xinitrc
ln -sf $(pwd)/.Xresources $HOME/.Xresources
ln -sf $(pwd)/.zshrc $HOME/.zshrc

sudo cp $(pwd)/add /usr/bin/add

# must add install ohmyzsh, modify zsh key binding, npm + pure prompt
# must add alacritty install
