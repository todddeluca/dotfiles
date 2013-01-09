
## Introduction

These are not the dot files you are looking for.  Move along.  You might find
the automated process for installing secrets (passwords, tokens, email
addresses) from an encrypted filesystem on Mac OS X interesting.

Since my bash scripting skills are minimal, the code is equally simple.


## Some Thoughts on Linking vs. Copying.

In this and other repositories, you might see that some people link their dot
files into `$HOME`, while other people copy them, and still other people do a
little bit of both.

Linking helps avoid the situation where you make a change to a dot file in
`$HOME` when you should have made the change to the file in the dotfiles dir
and then deployed it to `$HOME`.

Copying helps avoid the situation where you make a change, like adding a
password to a dot file in `$HOME`, and then you accidentally commit that change
to the dotfiles repository.


## Usage

    git clone https://github.com/todddeluca/dotfiles.git
    cd dotfiles
    ./install.sh
    ./install_secrets.sh
    ./install_vim.sh

## Sources of inspiration for how to organize and install dotfiles using github:

- https://github.com/sontek/dotfiles
- https://github.com/mathiasbynens/dotfiles
- https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles
- http://dotfiles.github.com/

