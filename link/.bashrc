# ~/.bashrc: executed by bash(1) for non-login shells.

# If running interactively, then:
if [ "$PS1" ]; then

    # don't put duplicate lines in the history. See bash(1) for more options
    export HISTCONTROL=ignoredups

    # append to the history file, don't overwrite it
    shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=10000
    HISTFILESIZE=20000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # make less friendlier for non-text input files.  see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi
    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi

    ###################
    # SSH CONFIGURATION
    # add creds for sshing to ec2 instances.
    if [ -f ~/.ssh/cbi-AWS-US-East.pem ]; then
      ssh-add ~/.ssh/cbi-AWS-US-East.pem 2>/dev/null
    fi

fi

# If running interactively, then:
if [ "$PS1" ]; then

  # Source git prompt and bash completion
  # From the homebrew location
  if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
  fi

  if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
  fi

  # Git prompt and completion setup
  PS1='\h:\W`__git_ps1`\$ '                                       # put the git info from PS1 in the prompt
  export GIT_PS1_SHOWDIRTYSTATE="1"                               # Display unstaged (*) and staged(+) changes
fi


###########################
# Make umask group-friendly.
# Since my default group is td23 and private to me anyway, this does not compromise
# security, but it allows collaboration with cbi more easily.
# And plays nicely with the setgid bit (see chmod)
umask 002


# a deployment script once wanted a group to assign to a file on localhost.
export GROUP=staff


############################
# Source configuration files

# Includes .bash_prompt, .bash_aliases
for f in ~/.bash.d/.bash_*; do
  source $f;
done

# Includes .bash_aws_tfd, .bash_aws_sysmed, .bash_gitconfig, .bash_email, .bash_ddc_secrets
for f in ~/.bash_secrets.d/.bash_*; do
  source $f;
done



########################
# DOCKER and Boot2Docker

# Output of boot2docker init; boot2docker start; $(boot2docker shellinit)
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1



#########################
# Set up amazon ec2 tools
export EC2_HOME=/Applications/ec2-api-tools-1.3-57419
export EC2_AMITOOL_HOME=/Applications/ec2-ami-tools-1.3-56066



#####
# DDC

# Adding build module to the path (first)
export PATH=$HOME/git/build/bin:$PATH

#########
# Vertica

PATH="$PATH:/usr/local/opt/vertica/bin"

###################
# DDC Remote Config
export REMOTE_CONFIG_HOST="vtfwk-zookeeper-vip.dealer.ddc"


########
# Grails
# Homebrew location
# export GRAILS_HOME=/usr/local/Cellar/grails/2.0.3/libexec
# Location preferred by DDC build scripts, using the download from the grails website.
export GRAILS_HOME=/opt/grails-2.0.3
export PATH="$PATH:$GRAILS_HOME/bin"


########
# Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec


#######
# SCALA
export SCALA_HOME=/usr/local/opt/scala210/idea
PATH="$PATH:$SCALA_HOME/bin"
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"


#########
# GO LANG

export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

#############################
# GIT

# Configure the location of .gitignore dynamically.
# This aids in using the same .bashrc with different home directories.
git config --global core.excludesfile "$HOME/.gitignore"


#############################
# PATH
# Consodidate PATH changes in one section
# Note: The order things are added to PATH matters.
# The last thing prepended has the highest precedence.
# The first thing appended has precedence of latter things appended.

# PREPEND
# Setting PATH for local installs, like python3
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
# Setting PATH for my bin dirs
PATH="$HOME/bin:$HOME/Dropbox/proj/dotfiles:$HOME/Dropbox/proj/dotfiles/bin:$PATH"

# APPEND
# amazon ec2 tools
PATH="$PATH:${EC2_AMITOOL_HOME}/bin:${EC2_HOME}/bin"
# mysql
PATH="$PATH:/usr/local/mysql/bin"
# ncbi blast
PATH="$PATH:/usr/local/ncbi/blast/bin"
# octave programming environment
PATH="$PATH:/Applications/Octave.app/Contents/Resources/bin"
# Homebrew Ruby Gem binaries default install location
# see 'brew info ruby'
PATH="$PATH:/usr/local/opt/ruby/bin"
# Node.js from Homebrew
PATH="$PATH:/usr/local/share/npm/bin"

# Setting PATH for Python 2.7
# PATH="/System/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# Setting PATH for mzscheme
PATH="/Applications/PLT Scheme v4.2.4/bin:${PATH}"

# Nvidia CUDA
export PATH="/Developer/NVIDIA/CUDA-5.0/bin:$PATH"
# uncomment to use / compile cuda if needed.  Commented out b/c DYLD_ vars
# makes various things complain, like `brew doctor` and `diskutil`.
# export DYLD_LIBRARY_PATH="/Developer/NVIDIA/CUDA-5.0/lib:${DYLD_LIBRARY_PATH}"

# STARDOG RDF/Semantic Web Triple-store
export PATH=$PATH:~/data/installs/stardog-1.2.2
export PATH
export STARDOG_HOME=~/data/stardog


# Configure the system-wide python GeneHawk uses for creating a virtualenv on
# localhost.
export GENEHAWK_SYSTEM_PYTHON=/usr/local/bin/python

export ROUNDUP_DEPLOY_USER=td23
export ORCHESTRA_USER=td23

# something to make mac os x and MySQLdb play nicely.
# http://stackoverflow.com/questions/4559699/python-mysqldb-and-library-not-loaded-libmysqlclient-16-dylibq
# I get complaints about setting this, especially from homebrew (e.g. on
# 2012/09/11) so try commenting it out and see what breaks.
# export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib

# Use MacVim to edit git commit messages, etc.
# export VISUAL="mvim -f"

# use /usr/bin/vim instead of vim to fix non-zero exit code when using vim to edit git
# commit messages.  Why does this work?
# http://tooky.github.com/2010/04/08/there-was-a-problem-with-the-editor-vi-git-on-mac-os-x.html
# export EDITOR="/usr/local/bin/vim"
# Fancy GUI editor
export VISUAL=vim
# barebones terminal editor
export EDITOR=vim
# Use Sublime Text
# export EDITOR='subl -n -w'

# Enable less to interpret raw control characters, used by ipython
export LESS='-R'

# Configure ruby 1.8 to use ruby gems.
# 1.8 is the ruby version in /usr/bin in Mac OS X 10.6 snow leopard
# export RUBYOPT="rubygems"

#######
# RBENV
# PATH="$PATH:$HOME/.rbenv/bin"
# Homebrew suggested this RBENV_ROOT
RBENV_ROOT=/usr/local/var/rbenv

# initialize rbenv
# if which rbenv > /dev/null ; then
#   eval "$(rbenv init -)";
# fi

##############
# Apache Maven
# export M2_HOME=/usr/local/Cellar/maven/3.2.2
# export M2=$M2_HOME/bin
# export PATH=$M2:$PATH
MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=768m -XX:ReservedCodeCacheSize=512m"
# Recommended for building Spark: export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
# Add spring-instrument to run DDC adw-services Spring webapp locally
# export MAVEN_OPTS="$MAVEN_OPTS -javaagent:$HOME/.m2/repository/org/springframework/spring-instrument/3.0.2.RELEASE/spring-instrument-3.0.2.RELEASE.jar -Dorg.mortbay.xml.XmlParser.NotValidating=true"
export DDC_BUILD_PATH=$HOME/git/build
export MAVEN_OPTS="$MAVEN_OPTS -javaagent:$DDC_BUILD_PATH/lib/spring-instrument-3.1.0.RELEASE.jar -Dorg.mortbay.xml.XmlParser.NotValidating=true"

#######
# SPARK
# This can fix a problem on mac os x, where running spark locally multiple times fails.
# https://groups.google.com/forum/#!msg/spark-users/XnDQgR1zTI0/mTozhw1PCvsJ
export SPARK_LOCAL_IP=127.0.0.1


######
# JAVA
# http://stackoverflow.com/questions/6588390/where-is-java-home-on-osx-lion-10-7-mountain-lion-10-8-or-mavericks-10-9
export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"
# export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export PATH="$PATH:$JAVA_HOME/bin"

# Quick switching between java 1.6 and 1.7
# export JAVA_HOME_1_6="$(/usr/libexec/java_home -v 1.6)"
# export JAVA_HOME_1_7="$(/usr/libexec/java_home -v 1.7)"
# alias j16="export JAVA_HOME=$JAVA_HOME_1_6"
# alias j17="export JAVA_HOME=$JAVA_HOME_1_7"

#########
# Haskell
export PATH=~/.cabal/bin:$PATH

################
# Julia Language
export PATH="$PATH:/Applications/Julia-0.2.1.app/Contents/Resources/julia/bin"

# Add Raptor (RDF parsing library) to PATH
export PATH="/usr/local/raptor/bin:$PATH"
