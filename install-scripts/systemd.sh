#!/usr/bin/env bash

function sys() {
  systemctl --user $@
}

sys start rss.service
sys enable rss.service

sed "s/{{USER}}/$(whoami)/g" ./config/systemd/user/battery.service.in > config/systemd/user/battery.service

sys start battery.service
sys enable battery.service
