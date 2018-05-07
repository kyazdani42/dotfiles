cp -r .vim ${HOME}/.vim

if [ ! -d "${HOME}/.vim/bundle" ]; then
	mkdir -p ${HOME}/.vim/bundle
fi

git clone https://github.com/scrooloose/nerdtree.git ${HOME}/.vim/bundle/nerdtree

ln -s ${HOME}/.vim/vimrc ${HOME}/.vimrc
