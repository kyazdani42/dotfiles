#!/bin/sh

BINARIES=(
# programs binaries
"$HOME/.deno/bin"
"$HOME/.local/share/cargo/bin"
"$HOME/.local/share/go/bin"
"$HOME/.config/yarn/bin"
"$HOME/.pyenv/bin"
# personnal binaries
"$HOME/.local/bin"
"$HOME/.local/workbin"
)

for p in "${BINARIES[@]}"; do
	[ -d "$p" ] && export PATH="$p:$PATH"
done

[ $(command -v "ssg-agent") ] && eval "$(ssh-agent -s)"
[ $(command -v "ssg-add") ] && [ -d "$HOME/.ssh/id_rsa.pub" ] && ssh-add "$HOME/.ssh/id_rsa.pub"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

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
# default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland-egl
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export XDG_CURRENT_DESKTOP=Unity
export XDG_SESSION_TYPE=wayland

if [ "$(tty)" = "/dev/tty1" ]; then
    export XDG_CURRENT_DESKTOP=sway
	exec sway &>/tmp/sway.log
    # exec wayfire -c ~/.config/wayfire/config.ini &>/tmp/wayfire.log
fi
