#!/usr/bin/env bash

terraform_install_tfenv() {
    local help=$(cat <<HELP
## terraform_install_tfenv

To install tfenv and help manage Terraform versions.
This will get installed to your '$HOME'/.tfenv directory. Once installed, reload your
shell environment.

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    [ ! -d ~/.tfenv ] && git clone https://github.com/tfutils/tfenv.git ~/.tfenv
}

command -v terraform > /dev/null
[ $? -eq 0 ] && alias tf="terraform"
