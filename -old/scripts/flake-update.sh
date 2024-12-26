#!/usr/bin/env bash

set -euo pipefail

echo "Updating NixOS flake configuration..."

# shellcheck disable=SC2086
cd $HOME/nixos-config
echo "Updating flake inputs..."
nix flake update

echo "Rebuilding NixOS configuration..."
# shellcheck disable=SC2086
sudo nixos-rebuild switch --flake $HOME/nixos-config

echo "NixOS update complete!"