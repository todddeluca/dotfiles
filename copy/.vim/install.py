#!/usr/bin/env python3

'''
A script for installing some vim bundles, most or all of which come from
github.  Instead of submodules, this script simply clones a set of urls
into a bundle directory.  To uninstall a bundle, just delete its repository
dir and installation url.

I tried using submodules but uninstalling a submodule is disturbingly
complicated.  Also, some repos are ill-formed, and so can not be installed
as simple submodules.  So I wrote this script.

Usage:

    # Install all repositories (deleting old repositories if they exist).
    ./install.py

    # Install just a few repositories which match the tokens
    ./install.py markdown fugitive tomorrow

'''

import argparse
import os
import subprocess
import sys


# mkdir colors
# download and install color schemes into colors dir
# see http://www.vimninjas.com/2012/09/14/10-light-colors/
# pyte
# http://www.vim.org/scripts/script.php?script_id=1492
# and summerfruit256
# http://www.vim.org/scripts/script.php?script_id=2577
# and autumnleaf
# http://www.vim.org/scripts/script.php?script_id=1107
# and oceanlight
# http://www.vim.org/scripts/script.php?script_id=1176
# and simpleandfriendly
# http://www.vim.org/scripts/script.php?script_id=792


# directory containing bundles/modules loaded by Pathogen
BUNDLE_DIR = os.path.expanduser('~/.vim/bundle')
REPOS_DIR = os.path.expanduser('~/.vim/repos')

TOMORROW_REPO = 'https://github.com/chriskempson/tomorrow-theme.git'
REPOS = [
    # 'https://github.com/hallison/vim-markdown.git',
    # 'https://github.com/plasticboy/vim-markdown.git',
    # 'https://github.com/sontek/rope-vim.git',
    # 'https://github.com/vim-scripts/AutoComplPop.git',
    'https://github.com/MarcWeber/vim-addon-mw-utils.git',
    'https://github.com/alfredodeza/pytest.vim.git',
    'https://github.com/altercation/vim-colors-solarized.git',
    'https://github.com/fholgado/minibufexpl.vim.git',
    'https://github.com/fs111/pydoc.vim.git',
    'https://github.com/garbas/vim-snipmate.git',
    'https://github.com/gg/python.vim.git',
    'https://github.com/honza/snipmate-snippets.git',
    'https://github.com/jmcantrell/vim-virtualenv.git',
    'https://github.com/kien/ctrlp.vim.git',
    'https://github.com/mileszs/ack.vim.git',
    'https://github.com/nvie/vim-flake8.git',
    'https://github.com/scrooloose/nerdcommenter.git',
    'https://github.com/scrooloose/syntastic.git',
    'https://github.com/sjl/gundo.vim.git',
    'https://github.com/sunaku/vim-unbundle.git',
    'https://github.com/tomtom/tlib_vim.git',
    'https://github.com/tpope/vim-abolish.git',
    'https://github.com/tpope/vim-fugitive.git',
    'https://github.com/tpope/vim-git.git',
    'https://github.com/tpope/vim-markdown.git',
    'https://github.com/tpope/vim-pathogen.git',
    'https://github.com/tpope/vim-repeat.git',
    'https://github.com/tpope/vim-surround.git',
    'https://github.com/vim-scripts/TaskList.vim.git',
    'https://github.com/vim-scripts/The-NERD-tree.git',
    'https://github.com/vim-scripts/closetag.vim.git',
]


def reponame(url):
    '''
    The basename of the directory into which the repo will be cloned.
    For example, 'ack.vim' for 'https://github.com/mileszs/ack.vim.git'.
    '''
    assert url[-4:] == '.git'
    return url.split('/')[-1][:-4]


def run(cmd, shell=True, cwd=None):
    print(cmd)
    return subprocess.check_call(cmd, shell=shell, cwd=cwd)


def install_tomorrow(url, clean=False):
    '''
    One off function for the tomorrow color theme repository, since its
    directory structure is not set up as a bundle.  Boo.
    '''
    # install/upgrade the repository somewhere
    name, repo_dir = install_repo(url, dest=REPOS_DIR, clean=clean)
    # plugin dir is the directory for this bundle in the bundle dir.
    plugindir = os.path.join(BUNDLE_DIR, name)
    # remove any existing installation
    run('rm -rf {pd}'.format(pd=plugindir))
    # make a dir for this bundle
    run('mkdir {pd}'.format(pd=plugindir))
    # copy the vim-specific files/dirs from the repo into the bundle dir
    run('rsync -a {rd}/vim/colors {pd}'.format(rd=repo_dir, pd=plugindir))


def install_repo(url, dest, clean=False):
    '''
    Clone the repository at url into a directory underneath dest or pull
    the repository if the directory already exist, implying it has already
    been cloned.  I.e. Install or update the vim bundle located at the
    url.

    dest: parent directory in which to clone this repository.  
      e.g. '~/.vim/bundle'
    clean: if True, delete any existing repo before installing it.
    '''
    name = reponame(url)
    repo_dir = os.path.join(dest, name)
    if clean:
        # remove any existing installation
        cmd1 = 'rm -rf {}'.format(repo_dir)
        print(cmd1)
        subprocess.check_call(cmd1, shell=True)

    if os.path.exists(repo_dir):
        cmd = 'git pull'
        print(cmd)
        subprocess.check_call(cmd, shell=True, cwd=repo_dir)
    else:
        # install the repo/bundle/module
        cmd2 = 'git clone {url}'.format(url=url)
        print(cmd2)
        subprocess.check_call(cmd2, shell=True, cwd=dest)

    return name, repo_dir


def tokens_match_url(tokens, url):
    '''
    Return True iff url contains any of the tokens.
    '''
    for token in tokens:
        if url.find(token) != -1:
            return True
    else:
        return False


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('--clean', action='store_true', help='Before ' +
            'installing a repository, remove any existing installation.')
    parser.add_argument('repos', nargs='*', help='One or more tokens.  ' + 
                        'Bundles containing these tokens will be installed.' +
                        'If none are given, all bundles will be installed.')
    args = parser.parse_args()
    print('args', args)
    if args.repos:
        # install matching repos
        def repo_flag(repo):
            return tokens_match_url(args.repos, repo)
    else:
        # install all repos
        def repo_flag(repo):
            return True

    # install all normal repos matching any repo flags.
    for r in REPOS:
        if repo_flag(r):
            print('installing', r)
            install_repo(r, BUNDLE_DIR, clean=args.clean)

    # install tomorrow repo if it matches a repo flag.
    if repo_flag(TOMORROW_REPO):
        print('installing', TOMORROW_REPO)
        install_tomorrow(TOMORROW_REPO, clean=args.clean)

if __name__ == '__main__':
    main()



