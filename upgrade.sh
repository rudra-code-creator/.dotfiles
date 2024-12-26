#!/bin/sh

# Script to update system and sync
# Does not pull changes from git

# shellcheck disable=SC3028
# shellcheck disable=SC3054
# shellcheck disable=SC3020
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Update flake
# shellcheck disable=SC2086
$SCRIPT_DIR/update.sh;

# Synchronize system
# shellcheck disable=SC2086
$SCRIPT_DIR/sync.sh;
