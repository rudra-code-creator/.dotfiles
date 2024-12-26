#!/bin/sh

# Script to synchronize system state
# with configuration files for nixos system
# and home-manager

# shellcheck disable=SC3028
# shellcheck disable=SC3054
# shellcheck disable=SC3020
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck disable=SC2086
$SCRIPT_DIR/sync-system.sh
# shellcheck disable=SC2086
$SCRIPT_DIR/sync-user.sh
