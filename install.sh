echo installing programs
sudo pacman -S git vim neovim polybar alacritty chromium compton vifm i3blocks zsh zathura nodejs npm yarn

echo install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo install pure prompt
mkdir -p $HOME/.zsh_functions
git clone https://github.com/sindresorhus/pure /tmp/pure
mv /tmp/pure/async.zsh /tmp/pure/pure.zsh $HOME/.zsh_functions
ln -s $HOME/.zsh_functions/pure.zsh $HOME/.zsh_functions/prompt_pure_setup
ln -s $HOME/.zsh_functions/async.zsh HOME/.zsh_functions/async


echo link home config file
ln -s $PWD/.gitconfig $HOME/.gitconfig
ln -s $PWD/.profile $HOME/.profile
ln -s $PWD/.xinitrc $HOME/.xinitrc
ln -s $PWD/.Xresources $HOME/.Xresources
ln -s $PWD/.zshrc $HOME/.zshrc

echo link home scripts
ln -s $PWD/.scripts $HOME/.scripts

echo link vim config
ln -s $PWD/.vim $HOME/.vim
ln -s $HOME/.vim/vimrc $HOME/.vimrc

echo link .config folders
ln -s $PWD/.config/alacritty $HOME/.config/alacritty
ln -s $PWD/.config/compton.conf $HOME/.config/compton.conf
ln -s $PWD/.config/i3 $HOME/.config/i3
ln -s $PWD/.config/i3blocks $HOME/.config/i3blocks
ln -s $PWD/.config/polybar $HOME/.config/polybar

