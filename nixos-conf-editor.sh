#!/bin/sh

# Documentation
# https://github.com/snowfallorg/nixos-conf-editor

# Function to display options
# shellcheck disable=SC2112
function display_menu() {
    echo "Choose an installation or execution method for nixos-conf-editor:"
    echo "1. Install using nix profile (NOT RECOMMENDED)"
    echo "2. Install using nix-env (NOT RECOMMENDED)"
    echo "3. Single run without flakes enabled"
    echo "4. Single run with flakes enabled"
    echo "5. Exit"
}

# Function for each method
function nix_profile_install() {
    echo "Installing using nix profile..."
    nix profile install github:snowfallorg/nixos-conf-editor
}

function nix_env_install() {
    echo "Installing using nix-env..."
    git clone https://github.com/snowfallorg/nixos-conf-editor
    nix-env -f nixos-conf-editor -i nixos-conf-editor
    echo "Cleaning up cloned repository..."
    rm -rf nixos-conf-editor
}

function single_run_noflakes() {
    echo "Running nixos-conf-editor with flakes enabled..."
    nix run github:snowfallorg/nixos-conf-editor
}

function single_run_experimental_flakes() {
    echo "Running nixos-conf-editor with experimental flakes enabled..."
    nix --extra-experimental-features "nix-command flakes" run github:snowfallorg/nixos-conf-editor
}

# Main menu loop
while true; do
    display_menu
    # shellcheck disable=SC3045
    read -r -p "Enter your choice (1-5): " choice

    case $choice in
        1)
            nix_profile_install
            break
            ;;
        2)
            nix_env_install
            break
            ;;
        3)
            single_run_noflakes
            break
            ;;
        4)
            single_run_experimental_flakes
            break
            ;;
        5)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            ;;
    esac
    echo
done
