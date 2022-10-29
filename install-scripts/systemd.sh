#!/usr/bin/env bash

function sys() {
  systemctl --user $@
}

sys daemon-reload
sys start rss.service
sys enable rss.service
