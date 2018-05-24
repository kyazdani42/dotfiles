cp -r .vim ${HOME}/.vim
vimplug=${HOME}/.vim/bundle/

if [ ! -d "${HOME}/.vim/bundle" ]; then
	mkdir -p $vimplug
fi

git clone https://github.com/scrooloose/nerdtree.git ${vimplug}nerdtree

#need clang to run YouCompleteMe installation
if [ `which clang` = "/usr/bin/clang" ]; then
	git clone https://github.com/Valloric/YouCompleteMe.git ${vimplug}/YouCompleteMe;
	cd ${vimplug}/YouCompleteMe;
	git submodule update --init --recursive;
	./install.py --clang-completer --systeme-libclang
	cd - >&-;
fi

ln -s ${HOME}/.vim/vimrc ${HOME}/.vimrc
