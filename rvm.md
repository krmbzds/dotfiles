RVM Installation
================

1. Switch to administrator account:

```
su - admin
```

2. Import GPG keys:

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

3. Multi-user installation:

```
\curl -sSL https://get.rvm.io | sudo bash -s stable
```

