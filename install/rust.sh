#!/bin/bash

if ! command -v cargo; then
	printf "installing rust and the toolchain\n"
	curl https://sh.rustup.rs -sSf | sh
fi

printf "installing procs"
cargo install procs

printf "installing starship prompt"
cargo install starship

