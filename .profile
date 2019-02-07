[[ -f ~/.zshrc ]] && . ~/.zshrc

export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"
# export BROWSER="qutebrowser"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi
feh --bg-scale $HOME/Pictures/Walls/wimWall.png
compton &
