# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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
CYAN='\033[0;36m'
if [ "$color_prompt" = yes ]; then
  : #null command in bash
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\] \W $(__git_ps1 '"'git:(%s)'"')\[\033[00m\]\$ '
#    PS1='➜  \[\033[01;36m\]\W\[\033[01;34m\] git:\[\033[01;31m\]$(__git_ps1 '"'(%s)'"')\[\033[01;34m\]\[\033[00m\]\$ '
    PS1='➜  \[\033[01;36m\]\W\[\033[01;34m\] \[\033[01;31m\]$(__git_ps1 '"'(%s)'"')\[\033[01;34m\]\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h: \w\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Load Angular CLI autocompletion.
source <(ng completion script)
source <(gh completion -s bash)
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/satvik/go/bin
complete -C '/usr/local/bin/aws_completer' aws
alias quit="exit"
alias gs="git status"
alias s145="ssh satvik@192.168.1.5"
alias gc="git commit"
alias notenow="vim ~/notes/$(date +%F_%R).txt"
alias notes="(cd ~/notes && ls -t)"
alias bye="shutdown now"
alias ubuntudocker="docker run -itd ubuntu:latest"
alias alpinedocker="docker run -itd alpine:latest"
alias pidofport="sudo netstat -nlp | grep $1"
alias gp="git push -u origin HEAD"
alias dcu="docker compose up -d --build"
alias dcd="docker compose down"
alias containers="docker ps -a"
alias images="docker images"
alias cpp20="g++ -std=c++20"
alias m="make"
alias fd="ls /proc/$$/fd"
touch2() { mkdir -p "$(dirname "$1")" && touch "$1" ; }
jsonify() {
    cat $1 | jq
}
codehere() {
  if [[ $1 ]]; then
    code -r $1
  else
    code -r .
  fi
}
clean() {
  if [[ -f Makefile ]]; then
    make clean
  else
    echo "No Makefile found"
  fi
}
pgconnect() {
  psql -U postgres -h localhost -p $1
}
alias kb-white="legion-kb-rgb set -e Static -c 63,63,63,63,63,63,63,63,63,63,63,63"
alias kb-red="legion-kb-rgb set -e Static -c 230,0,0,230,0,0,230,0,0,230,0,0"
alias cs451="cd ~/illinois-tech/cs451"
alias tmux="tmux new-session -A -s main"
alias gpu-stats="watch -n0.1 nvidia-smi"
export PATH=$HOME/.local/bin:$PATH
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

. "$HOME/.cargo/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/satvik/gcloud/google-cloud-sdk/path.bash.inc' ]; then . '/home/satvik/gcloud/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/satvik/gcloud/google-cloud-sdk/completion.bash.inc' ]; then . '/home/satvik/gcloud/google-cloud-sdk/completion.bash.inc'; fi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
