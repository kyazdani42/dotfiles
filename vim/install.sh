cp -r .vim ${HOME}/.vim

if [ ! -d "${HOME}/.vim/bundle" ]; then
	mkdir -p ${HOME}/.vim/bundle
fi

vimplug=${HOME}/.vim/bundle/

git clone https://github.com/scrooloose/nerdtree.git ${vimplug}/nerdtree
git clone https://github.com/tpop/vim-fugitive.git ${vimplug}/vim-fugitive

#need clang to run YouCompleteMe installation
if [ `which clang` = "/usr/bin/clang" ]; then
	git clone https://github.com/Valloric/YouCompleteMe.git ${vimplug}/YouCompleteMe;
	cd ${vimplug}/YouCompleteMe;
	git submodule update --init --recursive;
	./install.py --clang-completer --systeme-libclang
	cd - >&-;
fi

ln -s ${HOME}/.vim/vimrc ${HOME}/.vimrc
