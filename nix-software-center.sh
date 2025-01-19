#!/bin/sh

# DOCUMENTATION
# https://github.com/snowfallorg/nix-software-center

# Function to display options
# shellcheck disable=SC2112
function display_menu() {
    echo "Choose an installation or execution method for nix-software-center:"
    echo "1. Install using nix profile (NOT RECOMMENDED)"
    echo "2. Install using nix-env (NOT RECOMMENDED)"
    echo "3. Single run without flakes enabled"
    echo "4. Single run with flakes enabled"
    echo "5. Exit"
}

# Function for each method
function nix_profile_install() {
    echo "Installing using nix profile..."
    nix profile install github:snowfallorg/nix-software-center
}

function nix_env_install() {
    echo "Installing using nix-env..."
    git clone https://github.com/snowfallorg/nix-software-center
    nix-env -f nix-software-center -i nix-software-center
    echo "Cleaning up cloned repository..."
    rm -rf nix-software-center
}

function single_run_noflakes() {
    echo "Running nix-software-center with flakes enabled..."
    nix run github:snowfallorg/nix-software-center
}

function single_run_experimental_flakes() {
    echo "Running nix-software-center with experimental flakes enabled..."
    nix --extra-experimental-features "nix-command flakes" run github:snowfallorg/nix-software-center
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
