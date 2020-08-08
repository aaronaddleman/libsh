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

## jupyterlabs

To run LIBSH inside jupyterlabs:

1. install docker
1. git clone https://github.com/aaronaddleman/libsh
1. source libsh
   ```
   source libsh/libsh.sh fn
   ```
1. run function
   ```
   jupyter_labs_docker_base $PWD
   ```
1. wait for it to run bootstrapping
1. keep an eye out for something that looks like:
   ```
   Executing the command: jupyter lab
   info  Wrote default config file to ~/.config/code-server/config.yaml
   info  Using config file ~/.config/code-server/config.yaml
   info  Using user-data-dir ~/.local/share/code-server
   info  code-server 3.4.1 48f7c2724827e526eeaa6c2c151c520f48a61259
   info  HTTP server listening on https://0.0.0.0:8080
   info      - Using password from ~/.config/code-server/config.yaml
   info      - To disable use `--auth none`
   info    - Using generated certificate and key for HTTPS
   Generating a RSA private key
   ...............................................+++++
   ```

   and for this something like this

   ```
    To access the notebook, open this file in a browser:
        file:///home/addlema/.local/share/jupyter/runtime/nbserver-599-open.html
    Or copy and paste one of these URLs:
        https://12e4fce42da3:8888/?token=872e23100b584bd35d1d084161c7297897a45f6fc0deb459
     or https://127.0.0.1:8888/?token=872e23100b584bd35d1d084161c7297897a45f6fc0deb459

   ```
1. based on the info above you can now point your browser to these urls:
   ```
   # jupterlabs
   https://127.0.0.1:8888/?token=872e23100b584bd35d1d084161c7297897a45f6fc0deb459

   ```

   and

   ```
   # code-server
   https://177.0.0.1:8080
   ```

1. open up a terminal in jupyterlabs and type the following
   ```
   bash src/libsh/scripts/install_the_sink.sh
   ```
   then go for a walk around the block... this takes a long time...

1. at some point your asked for your country code(s)
   ```
   2 for america
   85 for Los Angeles
   ```

1. let the install continue
1. at some point you should see
   ```
           __                                     __
    ____  / /_     ____ ___  __  __   ____  _____/ /_
   / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
   / /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
   \____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/
                           /____/                       ....is now installed!

   ```
1. at this point, ohmyzsh has started a new shell... type the command
   ```
   exit
   ```

1. run the command
   ```
   ohmyzsh_install_spaceship
   ```
1. exit the shell(s)
1. start a new one
1. and your done
