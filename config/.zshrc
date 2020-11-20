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

DISABLE_MAGIC_FUNCTIONS=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_USE_ASYNC=1

# - - - - - - - - - - - - - - - - - - - -
# Zsh Plugin Management
# - - - - - - - - - - - - - - - - - - - -

source ~/.zinit/bin/zinit.zsh

zinit depth=1 lucid nocd for \
  romkatv/powerlevel10k

zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zinit ice multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null";
zinit load junegunn/fzf

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

export FZF_COMPLETION_TRIGGER=''
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fd -HIt f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# - - - - - - - - - - - - - - - - - - - -
# Key Bindings
# - - - - - - - - - - - - - - - - - - - -

zle -N autosuggest-execute
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
alias ls='exa -aF --git --color=always --color-scale -s=extension --group-directories-first'
alias tree='exa -T'

alias find='fd -HI -E=".git" --color=always'

alias vi='nvim'
alias vim='nvim'

alias gl='git log'
alias gdh='git diff HEAD'
alias gst='git status'
alias vimdiff='nvim -d'

alias nb='newsboat'
alias yt='newsboat -u ~/.config/newsboat/urls-youtube -c ~/.config/newsboat/urls-youtube.db'
alias nbdev='newsboat -u ~/.config/newsboat/urls-dev -c ~/.config/newsboat/urls-dev.db'
alias nbfin='newsboat -u ~/.config/newsboat/urls-tr-fin -c ~/.config/newsboat/urls-tr-fin.db'
alias nbgov='newsboat -u ~/.config/newsboat/urls-tr-gov -c ~/.config/newsboat/urls-tr-gov.db'
alias nbtr='newsboat -u ~/.config/newsboat/urls-tr-news -c ~/.config/newsboat/urls-tr-news.db'
alias nblit='newsboat -u ~/.config/newsboat/urls-tr-lit -c ~/.config/newsboat/urls-tr-lit.db'

alias sp='ncspot -b ~/.config/ncspot/'
