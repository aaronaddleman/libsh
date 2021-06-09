#!/usr/bin/env bash

python_install_virtualenv() {
    local help=$(cat <<HELP
## python_install_virtualenv

Just a simple pip install virtualenv. Validates pip exists first

...shell
python_install_virtualenv
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    [ $(command -v pip) ] && pip install virtualenv
}

python_install_virtualenvwrapper() {
    local help=$(cat <<HELP
## python_install_virtualenvwrapper

Just a simple pip install virtualenvwrapper. Validates pip exists first

...shell
python_install_virtualenvwrapper
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    [ $(command -v pip) ] && pip install virtualenvwrapper
}
