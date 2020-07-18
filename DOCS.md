## git_autocorrect

Enable git config help.autocorrect globally. This will help with command
spelling. The timeout allows you to cancel the command incase git still
gets it wrong.

Eg.

```shell
# set the autocorrect timeout for 8.0 seconds
git_autocorrect 80
```




## go_install_for_spacemacs

Installs all of the packages needed for doing
Go development.




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




## jupyter_labs_install_codeserver

Installs a the "code-server" to /usr/local/lib
Adds a link of /usr/local/bin/code-server to /usr/local/lib/code-server/code-server

Meant to run inside Jupyter for running an instance of "code-server"

To start the process and listen on all interfaces:

```shell
/usr/local/bin/code-server --host 0.0.0.0
```




## jupyter_labs_install_go

Installs a version of Go for Jupyter.

Meant to run inside Jupyter for installing Go support.




## jupyter_labs_install_go

Meant to run inside Jupyter for installing Go Kernel support

!!! UNDER DEVELOPMENT

Current issues:

1. Takes a long time to install
1. Kernel not allowed to be used. Might be due to Go not in /home/addlema/go dir




## ssh_ec2

SSH to ec2 instances using the ec2 user. Also passes a ton of ssh options.

Args needed are:

```shell
ssh_ec2 KeyToUse HostIp CommandToRun
```




## ssh_ec2

SSH to ec2 instances using the ec2 user. Also passes a ton of ssh options.

WORK IN PROGRESS




## terraform_install_tfenv

To install tfenv and help manage Terraform versions.
This will get installed to your '/home/addlema'/.tfenv directory. Once installed, reload your
shell environment.




## terragrunt_install_tgenv

To install tgenv and help manage Terragrunt versions.
This will get installed to your '/home/addlema'/.tgenv directory. Once installed, reload your
shell environment.




## aws_ami_shared_with

List the AWS accounts the AMI is shared with

Eg.

```shell
aws_ami_shared_with AMI-ID
```




## aws_find_instance_ips_by_name

Find instance ips by name

Eg.

```shell
aws_find_instance_ips_by_name "*Name*Pattern*"
aws_find_instance_ips_by_name "*EndName"
aws_find_instance_ips_by_name "StartName*"
```




## aws_vpcs_cidr

List cidr blocks for vpcs in current account

Eg.

```shell
aws_vpcs_cidr
```




## aws_vpc_sg

List security groups ID and description for current account

Eg.

```shell
aws_vpc_sg
```




## aws_vpc_subnets

List subnets groups ID and description for current account

Eg.

```shell
aws_vpc_sg
```




## figlet_ban

Fun banner with figlet and lolcat. There are some settings that are assumed
or you can replace them with your own. Below are the description and default
values.


```shell
# where you have your figlet fonts installed
FIGLET_FONT_DIR=/home/addlema/src/figlet-fonts

# what font file to use
LOLBAN_FONT_FILE=3d.flf

# font name to use
LOLBAN_FONT_NAME=3d

figlet_ban "your message"
```




## figlet_install_fonts

Install figlet fonts to the default of /home/addlema/src/figlet-fonts/ or
it accepts any dir you provide.

```shell
figlet_install_fonts
figlet_install_fonts your/destination
```




## git_autocorrect

Enable git config help.autocorrect globally. This will help with command
spelling. The timeout allows you to cancel the command incase git still
gets it wrong.

Eg.

```shell
# set the autocorrect timeout for 8.0 seconds
git_autocorrect 80
```




## git_clone

Git clone to a subdir based on the projects remote domain

Eg.

```shell
# clone the project of https://github.com/aaronaddleman/libsh
# this would result in being cloned to
# /home/addlema//home/addlema/src/github.com/aaronaddleman/libsh
#
git_clone https://github.com/aaronaddleman/libsh
```




## go_install_for_spacemacs

Installs all of the packages needed for doing
Go development.




## jupyter_datasci_rstudio

Start a jupyterlabs with datascience and rstudio as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

```shell
jupyter_labs_datasci_rstudio /path/to/your/project
```




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




## jupyter_labs_install_codeserver

Installs a the "code-server" to /usr/local/lib
Adds a link of /usr/local/bin/code-server to /usr/local/lib/code-server/code-server

Meant to run inside Jupyter for running an instance of "code-server"

To start the process and listen on all interfaces:

```shell
/usr/local/bin/code-server --host 0.0.0.0
```




## jupyter_labs_vscode

Start a jupyterlabs with vscode as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

```shell
jupyter_labs_simple /path/to/your/project docker_img
```




## jupyter_labs_vscode

Start a jupyterlabs with vscode as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

```shell
jupyter_labs_vscode /path/to/your/project docker_img_with_curl_installed
```




## jupyter_launch

Start a jupyter server.

To set additional args you can do the following:

```shell
export JUPYTER_ENABLE_LAB=t
export JUPYTER_CHOWN_HOME=t
export JUPYTER_BEFORE=/file/to/run/before/book.sh
export JUPYTER_CHOWN_EXTRA="/paths,/to,/also/chown"
export JUPYTER_CHOWN_HOME=t
export JUPYTER_CHOWN_HOME_OPTS="-R 770"
export JUPYTER_ENABLE_LAB=t
export JUPYTER_GRANT_SUDO=yes
export JUPYTER_NB_USER=addlema
export JUPYTER_OPTS="-e OtherOpt=Value -e MoreOpts=MoreThings"
export JUPYTER_RUN_ROOT=t
export JUPYTER_WORKDIR="/path/to/project"

jupyter_launch
```




## python_install_virtualenv

Just a simple pip install virtualenv. Validates pip exists first

```shell
python_install_virtualenv
```




## python_install_virtualenvwrapper

Just a simple pip install virtualenvwrapper. Validates pip exists first

```shell
python_install_virtualenvwrapper
```




## ssh_ec2

SSH to ec2 instances using the ec2 user. Also passes a ton of ssh options.

Args needed are:

```shell
ssh_ec2 KeyToUse HostIp CommandToRun
```




## ssh_ec2

SSH to ec2 instances using the ec2 user. Also passes a ton of ssh options.

WORK IN PROGRESS




## terraform_install_tfenv

To install tfenv and help manage Terraform versions.
This will get installed to your '/home/addlema'/.tfenv directory. Once installed, reload your
shell environment.




## terragrunt_install_tgenv

To install tgenv and help manage Terragrunt versions.
This will get installed to your '/home/addlema'/.tgenv directory. Once installed, reload your
shell environment.




## vault_decrypt_key

asks for your key wrapped in base64 and tries to decrypt it

```shell
vault_decrypt_key
```




## vault_eval

read a vault path and set variables with an optional prefix

eg.

```shell
vault_eval account/12345/sts/Application-Ops "mystuff_"
echo 
echo 
echo 
```




## vault_list

List known vaults from ~/.config/libsh/hc_vaults.json




## vault_login

Login to vault with VAULT_USER variable or the USER
variable. Use the VAULT_METHOD_VALUE for what method
to login with or just try logging in.

```shell
export VAULT_METHOD_VALUE=ldap
export VAULT_USER=aaronaddleman
vault_login
```




## vault_2_aws

Grab credentials from Vault and set to shell
environment variables.

Assumes user has logged into vault and  is setup properly given
vault path as input, reads from vault and exports AWS_ env vars properly

```shell
vault_2_aws path/to/aws/sts/role
```

If set the environment variable of LIBSH_USE_VAULT_LOGIN this function
will check the usage of your vault token and if its not valid, to try
login and prompt for password.




## vault_read

Read secrets from vault with curl

```shell
vault_read path/to/secret
```




## vault_setenv

Sets the VAULT_TOKEN to your .data.id value

```shell
vault_setenv
```




## vault_share

Share the contents of a file with another person

```shell
vault_share 10m mysecret.txt

➜ vault_share 2s mysecret.txt
Success! Data written to: cubbyhole/data
To share these secrets, tell the receiving party to use:
VAULT_ADDR=https://VAULTADDR:8200 VAULT_TOKEN=*********************rNH vault read -field=value cubbyhole/data
```

To remove your secret before the TTL:

```shell
vault token revoke 5sspSoLG3kWMBqTU4iXihrNH
```




## vault_use

Select one of the vault hosts using the name in /home/addlema/.config/libsh/hc_vaults.json

```shell
vault_use name_of_vault
```

This will set the following:

* VAULT_ADDR
* VAULT_METHOD
* VAULT_USER




## vault_verify_host

Validates a vault host. Defaults to 8200 and cannot be changed at this time.

```shell
vault_verify_host hostname.com
```




## aws_ami_shared_with

List the AWS accounts the AMI is shared with

Eg.

```shell
aws_ami_shared_with AMI-ID
```




## aws_find_instance_ips_by_name

Find instance ips by name

Eg.

```shell
aws_find_instance_ips_by_name "*Name*Pattern*"
aws_find_instance_ips_by_name "*EndName"
aws_find_instance_ips_by_name "StartName*"
```




## aws_vpcs_cidr

List cidr blocks for vpcs in current account

Eg.

```shell
aws_vpcs_cidr
```




## aws_vpc_sg

List security groups ID and description for current account

Eg.

```shell
aws_vpc_sg
```




## aws_vpc_subnets

List subnets groups ID and description for current account

Eg.

```shell
aws_vpc_sg
```




## figlet_ban

Fun banner with figlet and lolcat. There are some settings that are assumed
or you can replace them with your own. Below are the description and default
values.


```shell
# where you have your figlet fonts installed
FIGLET_FONT_DIR=/home/addlema/src/figlet-fonts

# what font file to use
LOLBAN_FONT_FILE=3d.flf

# font name to use
LOLBAN_FONT_NAME=3d

figlet_ban "your message"
```




## figlet_install_fonts

Install figlet fonts to the default of /home/addlema/src/figlet-fonts/ or
it accepts any dir you provide.

```shell
figlet_install_fonts
figlet_install_fonts your/destination
```




## git_autocorrect

Enable git config help.autocorrect globally. This will help with command
spelling. The timeout allows you to cancel the command incase git still
gets it wrong.

Eg.

```shell
# set the autocorrect timeout for 8.0 seconds
git_autocorrect 80
```




## git_clone

Git clone to a subdir based on the projects remote domain

Eg.

```shell
# clone the project of https://github.com/aaronaddleman/libsh
# this would result in being cloned to
# /home/addlema//home/addlema/src/github.com/aaronaddleman/libsh
#
git_clone https://github.com/aaronaddleman/libsh
```




## go_install_for_spacemacs

Installs all of the packages needed for doing
Go development.




## jupyter_datasci_rstudio

Start a jupyterlabs with datascience and rstudio as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

```shell
jupyter_labs_datasci_rstudio /path/to/your/project
```




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




## jupyter_labs_install_codeserver

Installs a the "code-server" to /usr/local/lib
Adds a link of /usr/local/bin/code-server to /usr/local/lib/code-server/code-server

Meant to run inside Jupyter for running an instance of "code-server"

To start the process and listen on all interfaces:

```shell
/usr/local/bin/code-server --host 0.0.0.0
```




## jupyter_labs_vscode

Start a jupyterlabs with vscode as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

```shell
jupyter_labs_simple /path/to/your/project docker_img
```




## jupyter_labs_vscode

Start a jupyterlabs with vscode as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

```shell
jupyter_labs_vscode /path/to/your/project docker_img_with_curl_installed
```




## jupyter_launch

Start a jupyter server.

To set additional args you can do the following:

```shell
export JUPYTER_ENABLE_LAB=t
export JUPYTER_CHOWN_HOME=t
export JUPYTER_BEFORE=/file/to/run/before/book.sh
export JUPYTER_CHOWN_EXTRA="/paths,/to,/also/chown"
export JUPYTER_CHOWN_HOME=t
export JUPYTER_CHOWN_HOME_OPTS="-R 770"
export JUPYTER_ENABLE_LAB=t
export JUPYTER_GRANT_SUDO=yes
export JUPYTER_NB_USER=addlema
export JUPYTER_OPTS="-e OtherOpt=Value -e MoreOpts=MoreThings"
export JUPYTER_RUN_ROOT=t
export JUPYTER_WORKDIR="/path/to/project"

jupyter_launch
```




## python_install_virtualenv

Just a simple pip install virtualenv. Validates pip exists first

```shell
python_install_virtualenv
```




## python_install_virtualenvwrapper

Just a simple pip install virtualenvwrapper. Validates pip exists first

```shell
python_install_virtualenvwrapper
```




## ssh_ec2

SSH to ec2 instances using the ec2 user. Also passes a ton of ssh options.

Args needed are:

```shell
ssh_ec2 KeyToUse HostIp CommandToRun
```




## ssh_ec2

SSH to ec2 instances using the ec2 user. Also passes a ton of ssh options.

WORK IN PROGRESS




## terraform_install_tfenv

To install tfenv and help manage Terraform versions.
This will get installed to your '/home/addlema'/.tfenv directory. Once installed, reload your
shell environment.




## terragrunt_install_tgenv

To install tgenv and help manage Terragrunt versions.
This will get installed to your '/home/addlema'/.tgenv directory. Once installed, reload your
shell environment.




## vault_decrypt_key

asks for your key wrapped in base64 and tries to decrypt it

```shell
vault_decrypt_key
```




## vault_eval

read a vault path and set variables with an optional prefix

eg.

```shell
vault_eval account/12345/sts/Application-Ops "mystuff_"
echo 
echo 
echo 
```




## vault_list

List known vaults from ~/.config/libsh/hc_vaults.json




## vault_login

Login to vault with VAULT_USER variable or the USER
variable. Use the VAULT_METHOD_VALUE for what method
to login with or just try logging in.

```shell
export VAULT_METHOD_VALUE=ldap
export VAULT_USER=aaronaddleman
vault_login
```




## vault_2_aws

Grab credentials from Vault and set to shell
environment variables.

Assumes user has logged into vault and  is setup properly given
vault path as input, reads from vault and exports AWS_ env vars properly

```shell
vault_2_aws path/to/aws/sts/role
```

If set the environment variable of LIBSH_USE_VAULT_LOGIN this function
will check the usage of your vault token and if its not valid, to try
login and prompt for password.




## vault_read

Read secrets from vault with curl

```shell
vault_read path/to/secret
```




## vault_setenv

Sets the VAULT_TOKEN to your .data.id value

```shell
vault_setenv
```




## vault_share

Share the contents of a file with another person

```shell
vault_share 10m mysecret.txt

➜ vault_share 2s mysecret.txt
Success! Data written to: cubbyhole/data
To share these secrets, tell the receiving party to use:
VAULT_ADDR=https://VAULTADDR:8200 VAULT_TOKEN=*********************rNH vault read -field=value cubbyhole/data
```

To remove your secret before the TTL:

```shell
vault token revoke 5sspSoLG3kWMBqTU4iXihrNH
```




## vault_use

Select one of the vault hosts using the name in /home/addlema/.config/libsh/hc_vaults.json

```shell
vault_use name_of_vault
```

This will set the following:

* VAULT_ADDR
* VAULT_METHOD
* VAULT_USER




## vault_verify_host

Validates a vault host. Defaults to 8200 and cannot be changed at this time.

```shell
vault_verify_host hostname.com
```




