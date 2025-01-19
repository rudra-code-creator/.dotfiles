#!/bin/sh

# Automated script to install my dotfiles




# Clone dotfiles
if [ $# -gt 0 ]
    then
        SCRIPT_DIR=$1
    else
        SCRIPT_DIR=~/.dotfiles
fi



nix-shell -p git --command "git clone https://github.com/rudra-code-creator/.dotfiles $SCRIPT_DIR"

# Generate hardware config for new system
# shellcheck disable=SC2086
# shellcheck disable=SC2024
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix

# Check if uefi or bios
if [ -d /sys/firmware/efi/efivars ]; then
    # shellcheck disable=SC2086
    sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"uefi\";/" $SCRIPT_DIR/flake.nix
else
    # shellcheck disable=SC2086
    sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"bios\";/" $SCRIPT_DIR/flake.nix
    grubDevice=$(findmnt / | awk -F' ' '{ print $2 }' | sed 's/\[.*\]//g' | tail -n 1 | lsblk -no pkname | tail -n 1 )
    # shellcheck disable=SC2086
    sed -i "0,/grubDevice.*=.*\".*\";/s//grubDevice = \"\/dev\/$grubDevice\";/" $SCRIPT_DIR/flake.nix
fi

# Patch flake.nix with different username/name and remove email by default
# shellcheck disable=SC2086
sed -i "0,/rudra/s//$(whoami)/" $SCRIPT_DIR/flake.nix
# shellcheck disable=SC2046
# shellcheck disable=SC2086
sed -i "0,/Rudra/s//$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)/" $SCRIPT_DIR/flake.nix
# shellcheck disable=SC2086
sed -i "s/rudrakeshwani2@gmail.com//" $SCRIPT_DIR/flake.nix
# shellcheck disable=SC2086
sed -i "s+~/.dotfiles+$SCRIPT_DIR+g" $SCRIPT_DIR/flake.nix

# Open up editor to manually edit flake.nix before install
if [ -z "$EDITOR" ]; then
    EDITOR=nano;
fi
# shellcheck disable=SC2086
$EDITOR $SCRIPT_DIR/flake.nix;

# Permissions for files that should be owned by root
# shellcheck disable=SC2086
# sudo $SCRIPT_DIR/harden.sh $SCRIPT_DIR;

# Rebuild system
# shellcheck disable=SC2086
sudo nixos-rebuild switch --flake $SCRIPT_DIR#system --impure;

# Install and build home-manager configuration
# shellcheck disable=SC2086
nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake $SCRIPT_DIR#user --impure;
