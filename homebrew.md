Homebrew Installation
=====================

0. Install Xcode:

```sh
xcode-select --install
```

1. Install Homebrew:

```sh
mkdir .homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C .homebrew
```

2. Add `~/.homebrew/bin` and `~/.homebrew/sbin` to your `PATH`:

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
path /usr/X11R6/bin
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
