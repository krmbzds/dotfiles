# - - - - - - - - - - - - - - - - - - - -
# Instant Prompt
# - - - - - - - - - - - - - - - - - - - -

source  ~/.cache/p10k-instant-prompt-${(%):-%n}.zsh

# - - - - - - - - - - - - - - - - - - - -
# Locale Settings
# - - - - - - - - - - - - - - - - - - - -

export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_CTYPE=$LANG

# - - - - - - - - - - - - - - - - - - - -
# Editor Preferences
# - - - - - - - - - - - - - - - - - - - -

export PAGER=less
export EDITOR=nvim
export VISUAL=subl

# - - - - - - - - - - - - - - - - - - - -
# History
# - - - - - - - - - - - - - - - - - - - -

HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=$HISTSIZE

# - - - - - - - - - - - - - - - - - - - -
# ZSH Autosuggestions
# - - - - - - - - - - - - - - - - - - - -

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'

# - - - - - - - - - - - - - - - - - - - -
# Zsh Plugin Management
# - - - - - - - - - - - - - - - - - - - -

source ~/.zinit/bin/zinit.zsh

zinit ice lucid ver'master' depth=1
zinit light romkatv/powerlevel10k

zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

autoload compinit
compinit

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light qoomon/zsh-lazyload

# - - - - - - - - - - - - - - - - - - - -
# Path Configuration
# - - - - - - - - - - - - - - - - - - - -

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

# - - - - - - - - - - - - - - - - - - - -
# Theme
# - - - - - - - - - - - - - - - - - - - -

source ~/.p10k.zsh
eval $(gdircolors ~/.config/dircolors/solarized.ansi-light)

# - - - - - - - - - - - - - - - - - - - -
# GPG Agent
# - - - - - - - - - - - - - - - - - - - -

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export FINGERPRINT="1B01B3C4EEFBE1730136D89338FD2B3F677F9C34"
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye >/dev/null

# - - - - - - - - - - - - - - - - - - - -
# Fuzzy Finder Settings
# - - - - - - - - - - - - - - - - - - - -

source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER=''
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# - - - - - - - - - - - - - - - - - - - -
# Key Bindings
# - - - - - - - - - - - - - - - - - - - -

bindkey '^ ' autosuggest-execute
bindkey '^[[Z' reverse-menu-complete
bindkey '^I' $fzf_default_completion
bindkey '^T' fzf-completion

# - - - - - - - - - - - - - - - - - - - -
# Version Managers
# - - - - - - - - - - - - - - - - - - - -

lazyload rvm -- 'source ~/.rvm/scripts/rvm'

# - - - - - - - - - - - - - - - - - - - -
# Aliases
# - - - - - - - - - - - - - - - - - - - -

alias c='clear'
alias l='exa -la'
alias ls='exa'
alias tree='exa -T'

alias vi='nvim'
alias vim='nvim'

alias gl='git log'
alias gdh='git diff HEAD'
alias gst='git status'
alias vimdiff='nvim -d'

alias nb='newsboat'
alias yt='newsboat -u ~/.config/newsboat/youtube-urls -c ~/.config/newsboat/youtube-cache.db'
