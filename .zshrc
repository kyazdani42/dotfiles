# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.scripts:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/kiyan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

plugins=(
  git
)
fpath+=('/home/kiyan/.zsh_functions')

source $ZSH/oh-my-zsh.sh

alias pacman="sudo pacman"
alias gitbeauty="git log --all --graph --oneline"
alias ls="exa"
alias cat="bat"
alias vim="nvim"

autoload -U promptinit; promptinit
prompt pure

\cat ~/todo

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

