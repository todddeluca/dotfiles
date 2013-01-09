#!/bin/bash


# The directory containing this script
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR=$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# The basedir of the dotfiles project.
DOTFILES=$DIR
echo "Dotfiles directory: $DOTFILES"

# copy everything in copy/ to ~/.
# DRYRUN="--dry-run"
DRYRUN=
rsync -avz $DRYRUN "$DOTFILES/copy/" $HOME


