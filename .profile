pgrep i3 || startx

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.pyenv/bin" ]; then
	PATH="$HOME/.pyenv/bin:$PATH"
fi

export PATH="$HOME/.cargo/bin:$PATH"

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_QPA_PLATFORMTHEME="qt5ct"

export EDITOR="/usr/bin/vim"
export TERMINAL="/usr/bin/alacritty"
export BROWSER="/usr/bin/chromium"
export GDK_SCALE=1
export GDK_SPI_SCALE=1

feh --bg-scale $HOME/Pictures/vimWall.png
compton &

