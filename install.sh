#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

function handle_errors {
	if [ $? != 0 ]; then
		echo $1
		exit 1
	fi
}

echo installing programs

sudo pacman -S git vim neovim dmenu polybar alacritty chromium compton vifm i3blocks zsh zathura nodejs npm yarn tmux
handle_errors "Error installing programs"

echo -----------------------------------------------------------------------------
echo install base16-shell colors

git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
handle_errors "Error cloning base16-shell colors"

echo -----------------------------------------------------------------------------
echo installing zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
handle_errors "Error installing oh my zsh"


echo installing pure prompt
git clone https://github.com/sindresorhus/pure /tmp/pure
handle_errors "Error cloning pure prompt"

mkdir -p $HOME/.zsh_functions
mv /tmp/pure/async.zsh /tmp/pure/pure.zsh $HOME/.zsh_functions
ln -s $HOME/.zsh_functions/pure.zsh $HOME/.zsh_functions/prompt_pure_setup
ln -s $HOME/.zsh_functions/async.zsh HOME/.zsh_functions/async
rm -rf /tmp/pure
rm $HOME/.zshrc
ln -s $PWD/.zshrc $HOME/.zshrc

echo -----------------------------------------------------------------------------
echo linking .profile, .gitconfig .xinitrc, .xresources, .scripts

rm -rf $HOME/{.gitconfig,.profile,.xinitrc,.Xresources,scripts}
ln -s $PWD/.gitconfig $HOME/.gitconfig
ln -s $PWD/.profile $HOME/.profile
ln -s $PWD/.xinitrc $HOME/.xinitrc
ln -s $PWD/.Xresources $HOME/.Xresources
ln -s $PWD/.scripts $HOME/.scripts

echo -----------------------------------------------------------------------------
echo link vim config

rm -rf $HOME{.vim,.vimrc}
ln -s $PWD/.vim $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc

echo install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
handle_errors "Error installing vim plug"

echo -----------------------------------------------------------------------------
echo link .config folders

rm -rf $HOME/.config/{nvim,alacritty,compton.conf,i3,i3blocks,polybar}
ln -s $PWD/.config/nvim $HOME/.config/nvim
ln -s $PWD/.config/alacritty $HOME/.config/alacritty
ln -s $PWD/.config/compton.conf $HOME/.config/compton.conf
ln -s $PWD/.config/i3 $HOME/.config/i3
ln -s $PWD/.config/i3blocks $HOME/.config/i3blocks
ln -s $PWD/.config/polybar $HOME/.config/polybar

