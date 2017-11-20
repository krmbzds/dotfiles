source ~/antigen.zsh

# Plugin configurations
antigen use oh-my-zsh
antigen bundle git
antigen bundle ssh-agent
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme robbyrussell
antigen apply

# Disable Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

PAGER=less
EDITOR=vim
VISUAL=vim

LANG=en_US.UTF-8
LC_ALL=$LANG
LC_CTYPE=$LANG

HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=$HISTSIZE

autoload -U colors && colors
autoload -U compinit -i && compinit -i
autoload -U promptinit && promptinit

setopt alwaystoend
setopt autocd
setopt autopushd
setopt nobeep
setopt completeinword
setopt correct
setopt extendedglob
setopt extendedhistory
setopt histignorealldups
setopt histignorespace
setopt histreduceblanks
setopt nocaseglob
setopt noclobber
setopt nullglob
setopt listtypes

zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' file-sort modification reverse
zstyle ':completion:*' format 'completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' hosts off
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose yes

if [ -f "${HOME}/.gpg-agent-info" ]; then
 . "${HOME}/.gpg-agent-info"
 export GPG_AGENT_INFO
 export SSH_AUTH_SOCK
 export SSH_AGENT_PID
fi
export GPG_TTY=$(tty)

function f {
  find . -iname "*$1*"
}

function fix_perm {
  sudo mkdir $2
  sudo chgrp -R $1 $2
  sudo chmod -R g+w $2
}

alias gpg="gpg2"

alias grep_ip="grep -Eo \
  '([0-9]{1,3}\.){3}[0-9]{1,3}'"
alias grep_url="grep -Eo \
  '(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'"

alias rand="for i in {1..5} ; do \
  gpg --gen-random --armor 1 30 ; \
  openssl rand -base64 30 ; \
  cat /dev/urandom | base64 | cut -c-40 | head -n5 ; done"

alias gpg_restart="pkill gpg-agent ; pkill ssh-agent ; \
  eval \$(gpg-agent --daemon --enable-ssh-support --use-standard-socket \
  --log-file ~/.gnupg/gpg-agent.log --write-env-file)"
