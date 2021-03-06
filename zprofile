#!/bin/sh

BINARIES=(
# programs binaries
"$HOME/.local/share/cargo/bin"
"$HOME/.local/share/go/bin"
"$HOME/.config/yarn/bin"
"$HOME/.pyenv/bin"
# personnal binaries
"$HOME/.local/bin"
"$HOME/.local/bin/bar"
)

for p in "${BINARIES[@]}"; do
	[ -d "$p" ] && export PATH="$p:$PATH"
done

[ $(command -v "ssh-agent") ] && eval "$(ssh-agent -s)"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export LESSHISTFILE="-"
export HISTFILE="$XDG_CACHE_HOME/bash_history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export PYTHONSTARTUP="$HOME/.local/bin/python_startup"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export DENO_DIR="$XDG_CONFIG_HOME/deno"
export MANPAGER="nvim -c 'set ft=man' -"
export PAGER="less"
# default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"

export RFC_DIR="$XDG_CACHE_HOME/RFCs"

source session-$(cat /etc/hostname)-$(whoami).sh
source /usr/share/wikiman/widgets/widget.zsh
