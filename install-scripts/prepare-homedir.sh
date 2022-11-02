#!/usr/bin/env bash

rm -rf $HOME/{P,p}ictures
rm -rf $HOME/.local/bin

mkdir -p $HOME/{dev,docs,music,videos,dl,gimp-projects,research,todos,books,.config,.local}

ln -sfv $PWD/Pictures $HOME/pictures
ln -sfv $PWD/bin $HOME/.local/bin
ln -sf $PWD/zprofile $HOME/.zprofile
