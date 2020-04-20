## go_install_for_spacemacs

Installs all of the packages needed for doing
Go development.
 
 
----
## jupyter_labs_docker_base

Runs jupyter labs base image with many options
that I think are helpful:

1. Enabling jupyter labs
1. Granting sudo
1. Setting user and group to current user
1. Generating a certificate
1. Running jupyterlabs_boot.sh with VS Code server
1. Mounting libsh as a volume
1. Using $1 as your workdir

```shell
juypter_labs_docker_base path/to/work/on
```

Your path/to/work/on is mounted to /home/addlema/work
 
 
----
## jupyter_labs_install_codeserver

Installs a the "code-server" to /usr/local/lib
Adds a link of /usr/local/bin/code-server to /usr/local/lib/code-server/code-server

Meant to run inside Jupyter for running an instance of "code-server"

To start the process and listen on all interfaces:

```shell
/usr/local/bin/code-server --host 0.0.0.0
```
 
 
----
## jupyter_labs_install_go

Installs a version of Go for Jupyter.

Meant to run inside Jupyter for installing Go support.
 
 
----
## jupyter_labs_install_go

Meant to run inside Jupyter for installing Go Kernel support

!!! UNDER DEVELOPMENT

Current issues:

1. Takes a long time to install
1. Kernel not allowed to be used. Might be due to Go not in /home/addlema/go dir
 
 
----
***elp
