#!/bin/sh
echo "Older generations"
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
echo "Cleaning up"
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +2
sudo nix-collect-garbage --delete-older-than 15d
