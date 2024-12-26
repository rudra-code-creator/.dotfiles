#!/bin/sh

# Script to synchronize system state
# with configuration files for nixos system
# and home-manager

# shellcheck disable=SC3028
# shellcheck disable=SC3054
# shellcheck disable=SC3020
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Fix root-owned sqlite errors
sudo chown -R 1000:users ~/.cache/nix;

# Fix existing gtk 2.0 backup error
sudo rm /home/rudra/.gtkrc-2.0.backup

# Install and build home-manager configuration
# shellcheck disable=SC2086
home-manager switch --flake $SCRIPT_DIR#user --impure -b backup;

# shellcheck disable=SC2086
$SCRIPT_DIR/sync-posthook.sh
