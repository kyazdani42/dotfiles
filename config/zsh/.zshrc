[ $TERM != "tmux-256color" ] && exec tmux -u -f $HOME/.config/tmux/tmux.conf
# configure oh my zsh
export HISTFILE="$HOME/.cache/zsh/history"
ZSH_THEME=""
export ZSH="$HOME/.config/zsh/oh-my-zsh"
plugins=(git zsh-autosuggestions docker colored-man-pages)

# launch oh my zsh
source $ZSH/oh-my-zsh.sh

fpath+=${ZDOTDIR:-~}/.zsh_functions

# open stuff mac style
function open() {
	&>/dev/null xdg-open $1 &
	disown
}

# unix aliases
alias p="sudo pacman"
alias ss="sudo systemctl"
alias sss="sudo systemctl status"
alias pacman="sudo pacman"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias bat="bat --decorations never"
alias ls="exa"
alias sl="exa"
alias la="exa -la --git"
alias lt="exa -Tla --git"
alias rm="rm -v"
alias mkdir="mkdir -v"

# git aliases
alias gitbeauty="git log --all --graph --oneline"
alias gpp="git push origin HEAD"

# tmux aliases
alias tls="tmux list-sessions"
alias tka="tmux kill-session -a"

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

