mkdir -p $HOME/.cache/zsh
export HISTFILE="$HOME/.cache/zsh/history"
HISTSIZE=500000
SAVEHIST=100000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

export LSCOLORS="Gxfxcxdxbxegedabagacad"

source $ZDOTDIR/completion.zsh
autoload -U compaudit compinit
autoload -U colors && colors
ZSH_COMPDUMP="${ZDOTDIR:-~}/.zcompdump"
compinit -u -C -d "${ZSH_COMPDUMP}"

autoload -Uz is-at-least
## jobs
setopt long_list_jobs
# recognize comments
setopt interactivecomments

fpath+=${ZDOTDIR:-~}/.zsh_functions
fpath+=${ZDOTDIR:-~}/zsh-completions/src
rm -f ${ZDOTDIR:-~}/.zcompdump; compinit

# open stuff mac style
open() {
  for file in $@; do
    &>/dev/null xdg-open $file &
    disown
  done
}

# unix aliases
alias sys="systemctl"
alias syss="systemctl status"
alias sysu="systemctl --user"
alias sysus="systemctl --user status"
alias bat="bat --decorations never --theme=ansi"
alias l="eza -l"
alias ls="eza"
alias sl="eza"
alias ll="eza -lg --git"
alias la="eza -lag --git"
alias lt="eza -Tla --git"
alias rm="rm -v"
alias mkdir="mkdir -v"
alias md="mkdir -p"
alias mus="ncmpcpp -c ~/.config/ncmpcpp/config"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias wget="wget --hsts-file='$HOME/.cache/wget-hsts'"
alias irssi="irssi --config="$XDG_CONFIG_HOME"/irssi/config --home="$XDG_DATA_HOME"/irssi"
alias yay="yay --color=always"

# git aliases
alias gpp="git push origin HEAD"
alias gp="git push"
alias gl="git pull"
alias ga="git add"
alias gc="git commit"
alias gca="git commit --amend"
alias gd="git diff"
alias gck="git checkout"
alias nvc="nvim ~/.config/nvim/"
alias nvsc="nvim ~/dev/scratch/scratch-\$RANDOM"

alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
alias ip="ip -c=always"

# the prompt
[ $(command -v starship) ] && eval "$(starship init zsh)"

# add syntax highlighting to zsh
source $ZDOTDIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

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

export ZVM_VI_ESCAPE_BINDKEY="^J"
source $ZDOTDIR/zsh-vi-mode/zsh-vi-mode.zsh
export KEYTIMEOUT=0
zvm_after_init_commands+=("[ \$(command -v fzf) ] && source $ZDOTDIR/fzf.zsh")

[ -f "venv/bin/activate" ] && source venv/bin/activate

[ -x "$(which zoxide)" ] && eval "$(zoxide init zsh)"
