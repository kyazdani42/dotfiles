#!/bin/bash

if ! command -v cargo; then
	printf "installing rust and the toolchain\n"
	curl https://sh.rustup.rs -sSf | sh
fi

printf "installing procs\n"
cargo install procs

printf "installing starship prompt\n"
cargo install starship

printf "installing pastel\n"
cargo install pastel

