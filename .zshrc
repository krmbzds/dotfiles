# Hello

function path {
  if [[ -d "$1" ]] ; then
    if [[ -z "$PATH" ]] ; then
      export PATH=$1
    else
      export PATH=$PATH:$1
    fi
  fi
}

export PATH=''

path ~/.homebrew/sbin
path ~/.homebrew/bin
path /usr/local/sbin
path /usr/local/bin
path /usr/sbin
path /usr/bin
path /sbin
path /bin

source ~/.antigen.zsh

antigen use oh-my-zsh
antigen bundle brew
antigen bundle brew-cask
antigen bundle gem
antigen bundle git
antigen bundle git-flow-avh
antigen bundle gpg-agent
antigen bundle osx
antigen bundle rvm
antigen bundle ssh-agent
antigen bundle vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme robbyrussell
antigen apply

LANG=en_US.UTF-8
LC_ALL=$LANG
LC_CTYPE=$LANG

PAGER=less
EDITOR=vim
VISUAL=vim

HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=$HISTSIZE

# Make Shift+Tab go back in autocomplete
bindkey '^[[Z' reverse-menu-complete

# Your secure and local home brewery
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha
export HOMEBREW_PREFIX=~/.homebrew/
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

# Replace ssh-agent with gpg-agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Load RVM *yoicks*
source ~/.rvm/scripts/rvm
