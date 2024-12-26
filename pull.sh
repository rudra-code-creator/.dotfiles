#!/bin/sh

# Automated script to update my non-primary systems
# config to be in sync with upstream git repo while
# preserving local edits to dotfiles via git stash

# shellcheck disable=SC3028
# shellcheck disable=SC3054
# shellcheck disable=SC3020
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Relax permissions temporarily so git can work
# shellcheck disable=SC2086
sudo $SCRIPT_DIR/soften.sh $SCRIPT_DIR;

# Stash local edits, pull changes, and re-apply local edits
# shellcheck disable=SC2164
# shellcheck disable=SC3044
# shellcheck disable=SC2086
pushd $SCRIPT_DIR &> /dev/null;
git stash;
git pull;
git stash apply;
# shellcheck disable=SC2164
# shellcheck disable=SC3044
popd &> /dev/null;

# Permissions for files that should be owned by root
# shellcheck disable=SC2086
sudo $SCRIPT_DIR/harden.sh $SCRIPT_DIR;
