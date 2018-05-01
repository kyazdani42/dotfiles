#creates vimrc link
#.vim folder must be in home when launching the script
ln -s ${HOME}/.vim/vimrc ${HOME}/.vimrc

if [ ! -d "bundle" ]; then
	mkdir -p bundle
fi

git clone https://github.com/scrooloose/nerdtree.git bundle/nerdtree
