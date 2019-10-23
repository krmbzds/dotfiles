NVM Installation
================

1. Clone the NVM repository:

```sh
git clone https://github.com/nvm-sh/nvm.git ~/.nvm
```

2. Check out to the latest NVM version branch:

```sh
cd ~/.nvm
git checkout v0.35.0
```

3. Load NVM into shell session (update `.zshrc`):

```sh
export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh ~/.nvm/bash_completion
```
