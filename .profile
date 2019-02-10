[[ -f ~/.zshrc ]] && . ~/.zshrc

export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"

# start xserver that will launch i3 through .xinitrc if i3 is not already running
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi

feh --bg-scale $HOME/Pictures/vimWall.png
compton &


export PATH="$HOME/.cargo/bin:$PATH"
