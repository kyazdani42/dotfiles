#!/bin/bash

sudo cp -r etc/lightdm /etc
sudo cp -r etc/X11/xinit /etc/X11
sudo systemctl enable lightdm.service

