# plugins
mkdir -p ${HOME}/.vim/autoload ${HOME}/.vim/bundle && \
git clone https://github.com/scrooloose/nerdtree.git ${HOME}/.vim/bundle/nerdtree && \
git clone https://github.com/fatih/vim-go.git ${HOME}/.vim/bundle/vim-go && \
curl -LSso ${HOME}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cp -r .vim/* ${HOME}/.vim

# vimrc
ln -s ${HOME}/.vim/vimrc ${HOME}/.vimrc

