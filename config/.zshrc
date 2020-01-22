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

# Locale settings
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_CTYPE=$LANG

# User preferences
export PAGER=less
export EDITOR=vim
export VISUAL=subl

# Shell history settings
HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=$HISTSIZE

# Brew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Zsh plugin management
source ~/.antigen.zsh
antigen use oh-my-zsh
antigen bundle brew
antigen bundle brew-cask
antigen bundle docker
antigen bundle docker-compose
antigen bundle gem
antigen bundle git
antigen bundle git-flow-avh
antigen bundle gpg-agent
antigen bundle osx
antigen bundle rvm
antigen bundle ssh-agent
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme robbyrussell
antigen apply

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

# Command line fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# My public key fingerprint
export FINGERPRINT="1B01B3C4EEFBE1730136D89338FD2B3F677F9C34"

# For my personal journal script
export JOURNAL_DIR=~/Documents/Repositories/Personal/journal
alias journal="$JOURNAL_DIR/journal"

# Load version managers (rustup, rvm, nvm, etc.)
test -s ~/.version-managers.sh && source ~/.version-managers.sh
