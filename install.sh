#!/bin/bash

if [ "$1" == "-h" ]; then
	echo "usage: ./install.sh (--init-system will try to install programs with pacman)"
	exit 0;
fi

function handle_errors {
	if [ $? != 0 ]; then
		echo $1
		exit 1
	fi
}

if [ "$1" == "--init-system" ]; then
	exec ./programs.sh
	handle_error "Error installing programs"
fi

if [ -f $HOME/.config/base16-shell ]; then
	echo -----------------------------------------------------------------------------
	echo install base16-shell colors

	git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
	handle_errors "Error cloning base16-shell colors"
fi

if [ -f $HOME/.oh-my-zsh ]; then
	echo -----------------------------------------------------------------------------
	echo installing zsh

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	handle_errors "Error installing oh my zsh"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	handle_errors "Error installing zsh-autosuggestions"
fi

echo -----------------------------------------------------------------------------
echo installing pure prompt
rm -rf $HOME/.zsh_functions /tmp/pure

git clone https://github.com/sindresorhus/pure /tmp/pure
handle_errors "Error cloning pure prompt"

mkdir -p $HOME/.zsh_functions
mv /tmp/pure/async.zsh /tmp/pure/pure.zsh $HOME/.zsh_functions
ln -s $HOME/.zsh_functions/pure.zsh $HOME/.zsh_functions/prompt_pure_setup
ln -s $HOME/.zsh_functions/async.zsh $HOME/.zsh_functions/async
rm -rf /tmp/pure
rm $HOME/.zshrc
ln -s $PWD/config/zshrc $HOME/.zshrc

echo -----------------------------------------------------------------------------
echo link vim config

rm -rf $HOME/{.vim,.vimrc}

ln -s $PWD/config/vim $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc


if [ -f $PWD/config/vim/autoload/plug.vim ]; then
	mkdir -p $PWD/config/vim/autoload
	echo install vim plug
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	handle_errors "Error installing vim plug"
fi

echo -----------------------------------------------------------------------------
echo link configuration

rm -rf $HOME/{.gitconfig,.profile,.xinitrc,.Xresources,Pictures}
rm -rf $HOME/.config/{nvim,alacritty,compton.conf,i3,i3blocks,polybar,tmux}

ln -s $PWD/Pictures $HOME/Pictures

ln -s $PWD/config/profile $HOME/.profile
ln -s $PWD/config/xinitrc $HOME/.xinitrc
ln -s $PWD/config/Xresources $HOME/.Xresources
ln -s $PWD/config/tmux $HOME/.config/tmux
ln -s $PWD/config/nvim $HOME/.config/nvim
ln -s $PWD/config/alacritty $HOME/.config/alacritty
ln -s $PWD/config/compton.conf $HOME/.config/compton.conf
ln -s $PWD/config/i3 $HOME/.config/i3
ln -s $PWD/config/polybar $HOME/.config/polybar

