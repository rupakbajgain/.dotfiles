#!/bin/sh

pushd ~/.dotfiles
#sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
sudo nixos-rebuild test --flake .#myNixos
popd
