if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]]; then exec tmux -f $HOME/.config/tmux/tmux.conf; fi
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.scripts:$PATH

export ZSH="/home/kiyan/.oh-my-zsh"

ZSH_THEME=""

#rg is ripgrep
export FZF_DEFAULT_COMMAND="rg --hidden -l "" -g '!.git' ."

if [[ $PLUG_PY == 1 ]]; then
	plugins=(
		git
		pyenv
		zsh-autosuggestions
		colored-man-pages
		ripgrep
	)
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
else
	plugins=(
		git
		zsh-autosuggestions
		colored-man-pages
		ripgrep
	)
fi

fpath+=('/home/kiyan/.zsh_functions')

source $ZSH/oh-my-zsh.sh

alias pacman="sudo pacman"
alias gitbeauty="git log --all --graph --oneline"
alias ls="exa"
alias cat="bat"
alias vim="nvim"

autoload -U promptinit; promptinit
prompt pure

\cat ~/.todo

