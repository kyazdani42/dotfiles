#!/usr/bin/env bash

# Sets up gtk values for application using dconf database

dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/interface/cursor-size 32
dconf write /org/gnome/desktop/interface/cursor-theme "'volantes_cursors'"
dconf write /org/gnome/desktop/interface/document-font-name "'DejaVu Sans 12'"
dconf write /org/gnome/desktop/interface/font-antialiasing "'rgba'"
dconf write /org/gnome/desktop/interface/font-name "'DejaVu Sans 12'"
dconf write /org/gnome/desktop/interface/gtk-theme "'palenight'"
dconf write /org/gnome/desktop/interface/icon-theme "'la-capitaine'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'NotoSansM Nerd Font 12'"
