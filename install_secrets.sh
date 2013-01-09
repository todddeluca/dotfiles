#!/bin/bash

set -x
set -v

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


