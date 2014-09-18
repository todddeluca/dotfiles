
# If running interactively, then:
if [ "$PS1" ]; then


  # Add an "alert" alias for long running commands.  Use like so:
  # sleep 10; alert
  # alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'




  # Enable color support for ls and grep
  # Create handy ls aliases
  # Detect OS, since color support and ls syntax vary by platform
  # http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
  case "$(uname)" in 
      Darwin)
          # with color
          alias ls='ls -GF'
          alias ll='ls -lGF'
          alias la='ls -laGF'
          # without color
          # alias ls='ls -F'
          # alias ll='ls -lF'
          # alias la='ls -laF'
          ;;

      Linux)
          if [ -x /usr/bin/dircolors ]; then
              test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
              alias ls='ls --color=auto'
              #alias dir='dir --color=auto'
              #alias vdir='vdir --color=auto'
              alias ll='ls -lF'
              alias la='ls -alF'
              alias l='ls -CF'
          fi
          ;;
  esac

  # Source .bashrc shortcut
  alias sb="source $HOME/.bashrc"

  # Maybe should test for dircolors first
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  # make rm a little safer and more annoying
  alias rm='rm -i'
  # spawns emacs in the shell, not in a separate window
  # --no-site-file prevents semantic caching CEDET packages from loading, packages which were slowing emacs down and creating bugs.
  alias bsi='bsub -Ip -q cbi_int_12h bash'
  alias bsim='bsub -Is -q interactive -W 720 -R "rusage[mem=16384]" bash'
  alias bsim32='bsub -Is -q interactive -W 720 -R "rusage[mem=32768]" bash'
  alias bsim64='bsub -Is -q interactive -W 720 -R "rusage[mem=64000]" bash'
  # shortcuts to log into my favorite hosts
  # Orchestra!
  alias ssho='ssh td23@orchestra.med.harvard.edu'
  # Home Webserver on EC2
  alias sshe='ssh -i ~/.ssh/cbi-AWS-US-East.pem ubuntu@ec2-23-21-160-23.compute-1.amazonaws.com'
  # Erik Gafni's GenomeKey server.
  alias sshg='ssh genomekey@genomekey.com'
  # Semantic Database server on EC2
  alias sshs='ssh -i ~/.ssh/tfd_20120531.pem ubuntu@ec2-23-21-187-71.compute-1.amazonaws.com'
  # Remove backup and pyc files.  Use to reduce grep noise from backup files.
  alias findrm='find . -type f \( -name "*~" -or -name "*\\.pyc" -or -name ".DS_Store" \) -delete'
  alias findls='find . -type f \( -name "*~" -or -name "*\\.pyc" -or -name ".DS_Store" \)'
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

  # aliases and functions to mount, grep, and unmount secrets
  function secgrep { 
    open ~/Dropbox/secrets.dmg && read -p 'Press a key to continue' -n 1 && grep "$1" /Volumes/secrets/secrets.txt | less ; diskutil eject /Volumes/secrets ;
  }
  alias secopen="open ~/Dropbox/secrets.dmg && read -p 'Press a key to continue' -n 1 && mvim /Volumes/secrets/secrets.txt"
  alias seceject="diskutil eject /Volumes/secrets"

  # grep for something in all pom files within and below the current dir
  # used for DDC and maven
  function greppom {
    grep "$1" `findpom`
  }
  alias findpom='find . -name pom.xml'

  # open emacs read only
  ev() {
    emacs "$1" --eval '(setq buffer-read-only t)'
  }

  # Make byobu faster and easier to type
  alias bu='byobu'

  # Shortcuts for work projects
  alias dordf='cd ~/deploy/rounduprdf && time venv/bin/python python/rdfmain.py'
  alias domirna='cd ~/deploy/vanvactor_mirna && time venv/bin/python python/rdfmain.py'
  alias ssv7='sudo service virtuoso-opensource-7.0'
  alias ssv6='sudo service virtuoso-opensource-6.1'

  # DDC
  # Open my DDC notes in MacVim
  alias mvimd='mvim $HOME/ddc-notes/ddc-notes.txt'

  # Prune local branches that have been merged on the remote
  # source: Will Briggs
  # source: http://stackoverflow.com/questions/13064613/git-how-to-prune-local-tracking-branches-that-do-not-exist-on-remote-anymore
  alias prunelocal='git branch -r | awk '\''{print $1}'\'' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '\''{print $1}'\'' | xargs git branch -d'

fi
