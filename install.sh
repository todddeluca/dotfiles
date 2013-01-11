#!/bin/bash

# The directory containing this script
# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR=$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# The basedir of the dotfiles project.
DOTFILES=$DIR
echo "Dotfiles directory: $DOTFILES"

# DRYRUN="--dry-run"
DRYRUN=

if [ "$1" = "bin" ]; then
  # since bin has no secrets, no need to rerun 'secrets'.
  rsync -av $DRYRUN "$DOTFILES/copy/bin" "$HOME"
elif [ "$1" = "bashrc" ]; then
  # since bashrc has no secrets, no need to rerun 'secrets'.
  rsync -av $DRYRUN "$DOTFILES/copy/.bashrc" "$HOME"
elif [ "$1" = "vim" ]; then
  # install vim bundles
  if [[ -e "$HOME/.vim/install.py" ]] ; then
    $HOME/.vim/install.py
  fi
elif [ "$1" = "copy" ]; then
  # copy everything in copy/ to ~/.
  rsync -avz $DRYRUN "$DOTFILES/copy/" $HOME
elif [ "$1" = "secrets" ]; then
  # mount encrypted secrets
  open $HOME/Dropbox/secrets.dmg
  read -p 'Waiting for secrets.dmg to mount. Press a key to continue. ' -n 1 

  # install secrets

  # copy dotfiles
  rsync -av "/Volumes/secrets/dotfiles/copy/" "${HOME}/"

  # add github credentials
  if [[ -f "$HOME/.bash_gitconfig" ]] ; then
    echo "Adding secrets to git config."
    source "$HOME/.bash_gitconfig"
  fi

  # defines EMAIL address
  source "$HOME/.bash_email"
  echo "$EMAIL from .bash_email"

  # insert email address into .crontab (from dotfiles repository).
  if [[ -e "$HOME/.crontab" ]] ; then
    echo "Changing 'foo@example.com' to '$EMAIL'."
    sed -i '' "s/MAILTO=foo@example.com/MAILTO=${EMAIL}/" "$HOME/.crontab"
  fi

  # unmount encrypted secrets
  # eject fails of current working directory is /Volumes/secrets
  lsof | grep secrets
  cd $HOME && diskutil eject /Volumes/secrets
else
  cat <<HELP

Usage: $(basename "$0") {copy,secrets,vim,bin,bashrc}

HELP
  exit;
fi


