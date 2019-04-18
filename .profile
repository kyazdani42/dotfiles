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

# start xserver that will launch i3 through .xinitrc if i3 is not already running
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi

feh --bg-scale $HOME/Pictures/vimWall.png
compton &


export PATH="$HOME/.cargo/bin:$HOME/.bin:$PATH"

