#!/bin/sh

# Script to update my flake without
# synchronizing configuration

# shellcheck disable=SC3028
# shellcheck disable=SC3054
# shellcheck disable=SC3020
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Update flake
# shellcheck disable=SC2164
# shellcheck disable=SC3044
# shellcheck disable=SC2086
pushd $SCRIPT_DIR &> /dev/null;
sudo nix flake update;
sudo nix-channel --update;
nix-channel --update;
# shellcheck disable=SC2164
# shellcheck disable=SC3044
popd &> /dev/null;
