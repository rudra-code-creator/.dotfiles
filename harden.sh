#!/bin/sh

# This will harden the security of these dotfiles, preventing
# unpriveleged users from editing system-level (root configuration)
# files maliciously

# Run this inside of ~/.dotfiles (or whatever directory you installed
# the dotfiles to)

# Run this as root!

# BTW, this assumes your user account has a PID/GID of 1000

# After running this, the command `nix flake update` will require root

if [ "$#" = 1 ]; then
    SCRIPT_DIR=$1;
else
    # shellcheck disable=SC3028
    # shellcheck disable=SC3054
    # shellcheck disable=SC3020
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
fi



# shellcheck disable=SC2164
# shellcheck disable=SC3044
# shellcheck disable=SC2086
# shellcheck disable=SC3020
pushd $SCRIPT_DIR &> /dev/null;
sudo chown 0:0 .;
sudo chown 0:0 profiles/*;
sudo chown -R 0:0 system;
sudo chown -R 0:0 patches;
sudo chown 0:0 flake.lock;
sudo chown 0:0 flake.nix
sudo chown 0:0 profiles
sudo chown 0:0 profiles/*/configuration.nix;
sudo chown 0:0 profiles/homelab/base.nix;
sudo chown 0:0 harden.sh;
sudo chown 0:0 soften.sh;
sudo chown 0:0 install.sh;
sudo chown 0:0 update.sh;
# shellcheck disable=SC2035
sudo chown 1000:users **/README.org;
# shellcheck disable=SC2164
# shellcheck disable=SC3044
# shellcheck disable=SC3020
popd &> /dev/null;
