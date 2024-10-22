#!/bin/sh

pushd ~/.dotfiles
#sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
sudo nixos-rebuild switch --flake .#myNixos
popd
