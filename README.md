# libsh

boot your sh

## install

* git clone https://github.com/aaronaddleman/libsh
* add libsh to your init files

```
# .zshrc
source $HOME/src/libsh/libsh.sh "fn"
# .zshenv
source $HOME/src/libsh/libsh.sh "env"
```

* add .libshrc from $HOME/src/libsh/.libshrc

This file selects which modules are loaded. This file
contains lots of comments about each option.

```
cp $HOME/src/libsh/.libshrc_example $HOME/.libshrc
```

* (optional) create a `$HOME/.sh.d/yourown.env.sh` or `$HOME/.sh.d/yourown.sh`.

LIBSH will load all `yourown.env.sh` or `yourown.sh` files from $HOME/.sh.d

## config files

### hc vaults

Creating a file like the following allows you to select vaults

```
cat $HOME/.config/libsh/hc_vaults.json

[
  {
    "name": "name_of_vault",
    "url": "https://hostname.of.vault.org:8200",
    "auth_user": "yourAccount",
    "auth_method": "ldap"
  },
  {
    "name": "another_vault",
    "url": "https://hostname.of.vault.org:8200",
    "auth_user": "yourAccount",
    "auth_method": "manual"
  }
]

```
