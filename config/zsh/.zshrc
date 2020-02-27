[ $TERM != "tmux-256color" ] && exec tmux -u -f $HOME/.config/tmux/tmux.conf
# configure oh my zsh
export HISTFILE="$HOME/.cache/zsh/history"
mkdir -p $HOME/.cache/zsh
ZSH_THEME=""
export ZSH="$HOME/.config/zsh/oh-my-zsh"
plugins=(git docker colored-man-pages)

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
alias bat="bat --decorations never --theme=ansi-dark"
alias ls="exa"
alias sl="exa"
alias la="exa -la --git"
alias lt="exa -Tla --git"
alias rm="rm -v"
alias mkdir="mkdir -v"
alias dnd="dragon-drag-and-drop"
alias mus="ncmpcpp -c ~/.config/ncmpcpp/config"

# git aliases
alias gitbeauty="git log --all --graph --oneline"
alias gpp="git push origin HEAD"

# tmux aliases
alias tls="tmux list-sessions"
alias tka="tmux kill-session -a"

alias showpic="sxiv"

# the prompt
[ $(command -v starship) ] && eval "$(starship init zsh)"

# must be sourced after starship
source $ZDOTDIR/zsh_vi_mode

# add syntax highlighting to zsh
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# fzf plugin for fast search
# `bindkey | grep fzf` for the key bindings
if [ $(command -v fzf) ]; then
    source $ZDOTDIR/fzf.zsh
fi
