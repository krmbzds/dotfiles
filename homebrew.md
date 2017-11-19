Homebrew Installation
=====================

1. Switch to administrator account:

```
su - admin
```

2. Install Homebrew:

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

3. Go to `System Preferences > Users & Groups` and add a new group called `brew`

4. Add Administrator and Standard accounts to the `brew` group

5. Update directory permissions for multi-user compatibility:

```
sudo chgrp -R brew /usr/local/*
sudo chmod -R g+w /usr/local/*
sudo mkdir /Library/Caches/Homebrew
sudo chgrp -R brew /Library/Caches/Homebrew
sudo chmod -R g+w /Library/Caches/Homebrew
sudo mkdir /opt
sudo chgrp -R brew /opt
sudo chmod -R g+w /opt
sudo mkdir /usr/local/Caskroom
sudo chgrp -R brew /usr/local/Caskroom
sudo chmod -R g+w /usr/local/Caskroom
sudo mkdir /usr/local/var/homebrew/locks/
sudo chgrp -R brew /usr/local/var/homebrew/locks/
sudo chmod -R g+w /usr/local/var/homebrew/locks/
```

6. Switch back to standard user:
```
exit
```

7. Check if everything is working properly:

```
brew doctor
```
