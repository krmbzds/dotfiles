RVM Installation
================

1. Import GPG Keys:

```sh
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

2. Download the Installer:

```sh
\curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
\curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc
```

3. Verify Installer Signature:

```sh
gpg --verify rvm-installer.asc
```

4. Run the Installer:

```sh
bash rvm-installer --branch stable --ignore-dotfiles
```

5. Load RVM into shell session (update `.zshrc`):

```sh
source ~/.rvm/scripts/rvm
```

6. Remove artifacts:

```sh
rm rvm-installer
rm rvm-installer.asc
```
