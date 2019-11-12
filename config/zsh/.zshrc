# configure oh my zsh
export HISTFILE="$HOME/.cache/zsh/history"
ZSH_THEME=""
export ZSH="$HOME/.config/zsh/oh-my-zsh"
plugins=(git zsh-autosuggestions docker colored-man-pages)

# launch oh my zsh
source $ZSH/oh-my-zsh.sh

# open stuff mac style
function open() {
	&>/dev/null xdg-open $1 &
	disown
}

# aliases
alias pacman="sudo pacman"
alias cht="curl cheat.sh/"
alias gitbeauty="git log --all --graph --oneline"
alias ls="exa"
alias la="exa -la --git"
alias lt="exa -Tla --git"
alias vim="nvim"
alias find="fd"
alias grep="rg"
alias less="bat"
alias gpo="git push origin"
alias glo="git pull origin"

# the prompt
[ $(command -v starship) ] && eval "$(starship init zsh)"

# must be sourced after starship
source $ZDOTDIR/zsh_vi_mode

# fzf plugin for fast search
if [ $(command -v fzf) ]; then
    export FZF_DEFAULT_COMMAND="rg --hidden -l "" -g '!.git' ."
    export FZF_DEFAULT_OPTS=' -i --color=bg:#292d3e,fg:#c7cfed,hl:#e74f7b,bg+:#292d3e,fg+:#e7edf9,hl+:#e74f6b,gutter:#292d3e,spinner:#292d3e,info:#292d3e,prompt:#292d3e,pointer:#80b9c9'
fi

# add syntax highlighting to zsh
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# `bindkey | grep fzf` for the key bindings
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
bindkey '^O' fzf-cd-widget
