# vim install
cp -r .vim ${HOME}/.vim
ln -sf ${HOME}/.vim/vimrc ${HOME}/.vimrc

# st install
cd ./st && make && sudo make install

# copy configs
cp -r .config $HOME

# copy home dotfiles
cp .gitconfig .profile .Xresources .zshrc $HOME

