#!/bin/bash

set -v
set -x


if [[ -e "$HOME/.vim/install.py" ]] ; then
  $HOME/.vim/install.py
fi

