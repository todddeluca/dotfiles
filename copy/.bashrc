# ~/.bashrc: executed by bash(1) for non-login shells.

# If running interactively, then:
if [ "$PS1" ]; then

    # don't put duplicate lines in the history. See bash(1) for more options
    export HISTCONTROL=ignoredups

    # append to the history file, don't overwrite it
    # shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    # HISTSIZE=10000
    # HISTFILESIZE=20000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    # shopt -s checkwinsize

    # make less friendlier for non-text input files.  see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
        *)
            ;;
    esac

    # Add an "alert" alias for long running commands.  Use like so:
    # sleep 10; alert
    # alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.

    # if [ -f ~/.bash_aliases ]; then
    #     . ~/.bash_aliases
    # fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    # if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    #     . /etc/bash_completion
    # fi

    # set a fancy prompt
    # PS1='\u@\h:\w\$ '

    # If this is an xterm set the title to user@host:dir
    #case $TERM in
    #xterm*)
    #    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    #    ;;
    #*)
    #    ;;
    #esac

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc).
    #if [ -f /etc/bash_completion ]; then
    #  . /etc/bash_completion
    #fi

    # aliases
    # alias ls='ls --color=auto'
    # alias grep='grep --color=auto'
    # alias fgrep='fgrep --color=auto'
    # alias egrep='egrep --color=auto'
    # alias ll='ls -alF'
    # alias la='ls -A'
    # alias l='ls -CF'
    # make rm a little safer and more annoying
    alias rm='rm -i'
    # with color
    alias ls='ls -GF'
    alias ll='ls -lGF'
    alias la='ls -laGF'
    # without color
    # alias ls='ls -F'
    # alias ll='ls -lF'
    # alias la='ls -laF'
    # spawns emacs in the shell, not in a separate window
    # --no-site-file prevents semantic caching CEDET packages from loading, packages which were slowing emacs down and creating bugs.
    alias bsi='bsub -Ip -q cbi_int_12h bash'
    # shortcuts to log into my favorite hosts
    alias ssho='ssh td23@orchestra.med.harvard.edu'
    alias sshe='ssh -i ~/.ssh/cbi-AWS-US-East.pem ec2-user@ec2-23-21-160-23.compute-1.amazonaws.com'
    alias sshg='ssh genomekey@genomekey.com'
    # remove backup and pyc files.  useful to reduce grep noise from backup files.
    alias findrm='find . -type f \( -name "*~" -or -name "*\\.pyc" \) -delete'
    alias findls='find . -type f \( -name "*~" -or -name "*\\.pyc" \)'
    # add group read and write perms (and execute perms to dirs and user executable files)
    # warning: avoid changing perms of $HOME or $HOME/.ssh to avoid making sshd angry!
    # alias findgrp='find . -user $USER \( -type d -exec chmod g+rwx {} \; -or -type f \( -perm -u+x -exec chmod g+rwx {} \; -or -exec chmod g+rw {} \; \) \)'

    # easily open notes.txt
    alias mvimn='mvim ~/Dropbox/notes/notes.txt'

    alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
    alias emacsn='emacs ~/Dropbox/notes/notes.txt'
    alias emacskd='ec -e "(kill-emacs)"'
    # alias emacs='open -a /Applications/Emacs.app'

    # convert dos or mac line endings to unix line endings, in place!
    # named after the real utility, dos2unix, which is not on my mac.
    alias mac2unix="perl -pi -e 's/\r\n?/\n/g'"

    # Remove the history numbers from the beginning of history lines.  Useful for cutting and pasting history.
    alias historyn="history | python -c 'import sys; [sys.stdout.write(l.lstrip().split(\"  \", 1)[1]) for l in sys.stdin]'"
    # alternative awk implementation
    # alias historyn='history | awk '\''{$1="";$0=substr($0,2)}1'\'''

    # mount, grep, and unmount secrets
    function grepsec { 
      open ~/Dropbox/secrets.dmg && read -p 'Press a key to continue' -n 1 && grep "$1" /Volumes/secrets/secrets.txt | less ; diskutil eject /Volumes/secrets ;
    }

    # open emacs read only
    ev() {
      emacs "$1" --eval '(setq buffer-read-only t)'
    }

    ###################
    # SSH CONFIGURATION
    # add creds for sshing to ec2 instances.
    ssh-add ~/.ssh/cbi-AWS-US-East.pem 2>/dev/null

fi


###########################
# Make umask group-friendly.  
# Since my default group is td23 and private to me anyway, this does not compromise 
# security, but it allows collaboration with cbi more easily.
# And plays nicely with the setgid bit (see chmod)
umask 002


# a deployment script once wanted a group to assign to a file on localhost.
export GROUP=staff


#########################
# Set up amazon ec2 tools
export EC2_HOME=/Applications/ec2-api-tools-1.3-57419
export EC2_AMITOOL_HOME=/Applications/ec2-ami-tools-1.3-56066


####################
# Secret Credentials
# Env vars used by boto, aws cli, etc.
if [ -f "$HOME/.bash_aws_tfd" ] ; then
  source "$HOME/.bash_aws_tfd"
fi
# Env vars used by SysMed
if [ -f "$HOME/.bash_sysmed" ] ; then
  source "$HOME/.bash_sysmed"
fi
# Git and Github credentials
if [ -f "$HOME/.bash_gitconfig" ] ; then
  source "$HOME/.bash_gitconfig"
fi


#############################
# PATH
# Consodidate PATH changes in one section
# Note: The order things are added to PATH matters.
# The last thing prepended has the highest precedence.
# The first thing appended has precedence of latter things appended.

# PREPEND
# Executables for python3 are sometimes installed here, e.g. pip3.
PATH="/usr/local/share/python3:$PATH"
# Where pip installer puts pip, based on hombrew python install.
PATH="/usr/local/share/python:$PATH"
# Setting PATH for local installs, like python3
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
# Setting PATH for my bin
PATH="~/bin:$PATH"

# APPEND
# amazon ec2 tools
PATH="$PATH:${EC2_AMITOOL_HOME}/bin:${EC2_HOME}/bin"
# mysql
PATH="$PATH:/usr/local/mysql/bin"
# ncbi blast
PATH="$PATH:/usr/local/ncbi/blast/bin"
# octave programming environment
PATH="$PATH:/Applications/Octave.app/Contents/Resources/bin"
# rvm
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# rbenv
PATH="$PATH:$HOME/.rbenv/bin"
# Homebrew Ruby Gem binaries default install location
# see 'brew info ruby'
PATH="$PATH:/usr/local/Cellar/ruby/1.9.3-p362/bin"

# Setting PATH for Python 2.7
# PATH="/System/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# Setting PATH for mzscheme
PATH="/Applications/PLT Scheme v4.2.4/bin:${PATH}"

# Nvidia CUDA
export PATH="/Developer/NVIDIA/CUDA-5.0/bin:$PATH"
# uncomment to use / compile cuda if needed.  Commented out b/c DYLD_ vars
# makes various things complain, like `brew doctor` and `diskutil`.
# export DYLD_LIBRARY_PATH="/Developer/NVIDIA/CUDA-5.0/lib:${DYLD_LIBRARY_PATH}"

export PATH

# Configure the system-wide python GeneHawk uses for creating a virtualenv on
# localhost.
export GENEHAWK_SYSTEM_PYTHON=/usr/local/bin/python


# something to make mac os x and MySQLdb play nicely.
# http://stackoverflow.com/questions/4559699/python-mysqldb-and-library-not-loaded-libmysqlclient-16-dylibq
# I get complaints about setting this, especially from homebrew (e.g. on
# 2012/09/11) so try commenting it out and see what breaks.
# export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib

# Use MacVim to edit git commit messages, etc.
export VISUAL="mvim -f"

# use /usr/bin/vim instead of vim to fix non-zero exit code when using vim to edit git 
# commit messages.  Why does this work?
# http://tooky.github.com/2010/04/08/there-was-a-problem-with-the-editor-vi-git-on-mac-os-x.html
export EDITOR=/usr/bin/vim

# Enable less to interpret raw control characters, used by ipython
export LESS='-R'

# Configure ruby 1.8 to use ruby gems.
# 1.8 is the ruby version in /usr/bin in Mac OS X 10.6 snow leopard 
# export RUBYOPT="rubygems"

# initialize rbenv
if which rbenv > /dev/null ; then 
  eval "$(rbenv init -)"; 
fi



