#!/bin/bash

if [ "$1" == "-h" -o "$1" == "--help" ]; then
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

if [ ! -d $HOME/.config/base16-shell ]; then
	echo -----------------------------------------------------------------------------
	echo install base16-shell colors

	git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell &>/dev/null
	handle_errors "Error cloning base16-shell colors"
	echo "base16-shell colors installed"
fi

if [ ! -d $HOME/.oh-my-zsh ]; then
	echo -----------------------------------------------------------------------------
	echo installing oh my zsh

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &>/dev/null
	handle_errors "Error installing oh my zsh"

	#enable vi key binding
	sed -i 's/bindkey -e/bindkey -v\nexport KEYTIMEOUT=1/g' $HOME/.oh-my-zsh/lib/key-bindings.zsh
	echo "oh my zsh installed"

	echo "installing zsh-autosuggestions"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &>/dev/null
	handle_errors "Error installing zsh-autosuggestions"
	echo "zsh-autosuggestions installed"
fi

if [ ! -f $HOME/.zsh_functions/async ]; then
	echo -----------------------------------------------------------------------------
	echo "installing pure prompt"
	rm -rf $HOME/.zsh_functions /tmp/pure

	git clone https://github.com/sindresorhus/pure /tmp/pure &>/dev/null
	handle_errors "Error cloning pure prompt"

	mkdir -p $HOME/.zsh_functions
	mv /tmp/pure/async.zsh /tmp/pure/pure.zsh $HOME/.zsh_functions
	ln -s $HOME/.zsh_functions/pure.zsh $HOME/.zsh_functions/prompt_pure_setup
	ln -s $HOME/.zsh_functions/async.zsh $HOME/.zsh_functions/async
	rm -rf /tmp/pure
	echo "pure prompt installed"
fi

echo -----------------------------------------------------------------------------
echo link zsh config

rm $HOME/.zshrc
ln -s $PWD/config/zshrc $HOME/.zshrc

echo -----------------------------------------------------------------------------
echo link vim config

rm -rf $HOME/{.vim,.vimrc}

ln -s $PWD/config/vim $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc


if [ ! -f $PWD/config/vim/autoload/plug.vim ]; then
	mkdir -p $PWD/config/vim/autoload
	echo install vim plug
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	handle_errors "Error installing vim plug"
	echo "vim plug installed"
fi

echo -----------------------------------------------------------------------------
echo link configurations

rm -rf $HOME/{.profile,.xinitrc,.Xresources,Pictures,.gtkrc-2.0}
rm -rf $HOME/.config/{nvim,alacritty,compton.conf,i3,i3blocks,polybar,tmux,gtk-3.0}

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
ln -s $PWD/config/gtk-3.0 $HOME/.config/gtk-3.0
ln -s $PWD/config/gtkrc-2.0 $HOME/.gtkrc-2.0
