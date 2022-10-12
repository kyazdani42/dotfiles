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

# xdg defs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# xdg config dirs
export DENO_DIR="$XDG_CONFIG_HOME/deno"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# xdg data dirs
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export LEIN_HOME="$XDG_DATA_HOME"/lein
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"

# xdg cache dirs
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node_repl_history"
export HISTFILE="$XDG_CACHE_HOME/bash_history"
export RFC_DIR="$XDG_CACHE_HOME/RFCs"

export PYTHONSTARTUP="$HOME/.local/bin/python_startup"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export LESSHISTFILE="-"
export MANPAGER='nvim +Man!'
export PAGER="less"

# default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"

source session-$(cat /etc/hostname)-$(whoami).sh
