#!/bin/bash

if ! command -v cargo >/dev/null
then
	echo "** installing rust and the toolchain **"
	curl https://sh.rustup.rs -sSf | sh
fi

