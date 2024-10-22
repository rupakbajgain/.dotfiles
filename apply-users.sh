#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/rupak/home.nix
popd
