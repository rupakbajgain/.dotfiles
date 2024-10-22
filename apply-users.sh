#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/rupak/home.nix
#copy if it does not exists
cp -n ./users/rupak/nbfc.json ~/.config/
popd
