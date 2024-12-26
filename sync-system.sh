#!/bin/sh

# Script to synchronize system state
# with configuration files for nixos system
# and home-manager

# shellcheck disable=SC3028
# shellcheck disable=SC3054
# shellcheck disable=SC3020
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Rebuild system
# shellcheck disable=SC2086
sudo nixos-rebuild switch --flake $SCRIPT_DIR#system;
