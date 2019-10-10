Homebrew Installation
=====================

1. Install Xcode Command Line Tools:

```sh
xcode-select --install
```

2. Install Homebrew:

```sh
mkdir .homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C .homebrew
```

3. Add `~/.homebrew/bin` and `~/.homebrew/sbin` to your `PATH`:

```sh
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
```

3. Check if everything is working properly:

```
brew doctor
```

You will see the following warning, which is expected: 

```
Warning: Your Homebrew's prefix is not /usr/local.
You can install Homebrew anywhere you want but some bottles (binary packages)
can only be used with a /usr/local prefix and some formulae (packages)
may not build correctly with a non-/usr/local prefix.
```

You're done.


## Software Installation (Optional)

You can use [Homebrew Bundle][homebrew-bundle] to systematically install software:

```sh
brew bundle  # --file=~/Brewfile
```

For this to work, you need to create a Brewfile like [this one][my-brewfile]:

```rb
tap 'homebrew/core'
tap 'homebrew/services'
tap 'homebrew/cask'
tap 'homebrew/cask-fonts'

brew 'fd'
brew 'fzf'
brew 'git'
brew 'gnupg'
brew 'pinentry-mac'
brew 'postgresql'
brew 'rclone'
brew 'tree'
brew 'vim'
brew 'youtube-dl'
brew 'zsh'

cask 'font-source-code-pro'

cask 'brave-browser',       args: { appdir: '~/Applications' }
cask 'iterm2',              args: { appdir: '~/Applications' }
cask 'omnifocus',           args: { appdir: '~/Applications' }
cask 'sublime-merge',       args: { appdir: '~/Applications' }
cask 'sublime-text',        args: { appdir: '~/Applications' }

cask 'anki',                args: { appdir: '~/Applications/Utilities' }
cask 'appcleaner',          args: { appdir: '~/Applications/Utilities' }
cask 'calibre',             args: { appdir: '~/Applications/Utilities' }
cask 'insomnia',            args: { appdir: '~/Applications/Utilities' }
cask 'karabiner-elements',  args: { appdir: '~/Applications/Utilities' }
cask 'keka',                args: { appdir: '~/Applications/Utilities' }
cask 'macs-fan-control',    args: { appdir: '~/Applications/Utilities' }
cask 'netnewswire',         args: { appdir: '~/Applications/Utilities' }
cask 'postico',             args: { appdir: '~/Applications/Utilities' }
cask 'spectacle',           args: { appdir: '~/Applications/Utilities' }
cask 'transmission',        args: { appdir: '~/Applications/Utilities' }
cask 'vlc',                 args: { appdir: '~/Applications/Utilities' }
```

Apart from the initial installation, it is also possible to enforce your Brewfile: 

```sh
brew bundle cleanup --force  # --file=~/Brewfile
```

This will remove any package that's not present or dependent to a package listed in your Brewfile.


[homebrew-bundle]: https://github.com/Homebrew/homebrew-bundle
[my-brewfile]: ../config/Brewfile
