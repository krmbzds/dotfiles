#!/bin/sh

# Version Manager Configurations
# Source this file in your shell profile to use it

# Rust version manager
function activate_rustup {
  path ~/.cargo/bin
}

# Ruby version manager
function activate_rvm {
  source ~/.rvm/scripts/rvm
}

# Node version manager
function activate_nvm {
  export NVM_DIR=~/.nvm
  source ~/.nvm/nvm.sh ~/.nvm/bash_completion
}

# ASDF version manager
function activate_asdf {
  source ~/.asdf/asdf.sh
  source ~/.asdf/completions/asdf.bash
}

# activate_rustup
# activate_rvm
# activate_nvm
# activate_asdf
