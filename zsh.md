ZSH Installation
================

1. Install ZSH using Homebrew:

```
brew install zsh
```

2. Install Antigen to manage plugins:

```
curl -L git.io/antigen > ~/.antigen.zsh
```

3. Get ZSH config files from my dotfiles repo:

```
curl -L https://git.io/vFQoT > ~/.zshrc
```

4. Switch non-admin user's shell to ZSH:

```
su - admin
sudo dscl . -create /Users/kerem UserShell /Users/kerem/.homebrew/bin/zsh
```
