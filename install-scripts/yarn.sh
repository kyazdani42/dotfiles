#!/usr/bin/env bash

yarn_path_config() {
  yarn -s --use-yarnrc "$HOME/.config/yarn/config" \
    config set $1 "$HOME/.config/yarn" &>/dev/null
}

if command -v yarn >/dev/null; then
  yarn_path_config prefix
  yarn_path_config global-folder
fi
