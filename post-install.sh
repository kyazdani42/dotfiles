#!/usr/bin/env bash

set -euo pipefail

./install-scripts/prepare-homedir.sh

for config_file in config/*; do
  link_name="$HOME/.config/$file"
  rm -rfv "$link_name"
  target="$PWD/$file"
  ln -sfv "$target" "$link_name"
done

session_file="bin/session-$(hostname)-$(whoami).sh"
if [ ! -f "$session_file" ]; then
    cp -v session-template.sh "$session_file"
    chmod +x "$session_file"
fi

alacritty_config="config/alacritty/alacritty.yml"
if [ ! -f "$alacritty_config" ]; then
    cp -v "config/alacritty/config-base.yml" "$alacritty_config"
fi

nwgbar_conf="config/nwg-launchers/nwgbar/bar.json"
if [ ! -f "$nwgbar_conf" ]; then
    cp -v "config/nwg-launchers/nwgbar/bar.template.json" "$nwgbar_conf"
    sed -i "s/\\$\\$/$(whoami)/g" "$nwgbar_conf";
fi

./install-scripts/neovim.sh
./install-scripts/yarn.sh
./install-scripts/dconf.sh
./install-scripts/systemd.sh

echo "Installation is done, you should restart your session"
