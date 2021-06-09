#!/usr/bin/env bash

if [ -d $HOME/.pyenv ]; then
    # set the PYENV_ROOT
    export PYENV_ROOT="$HOME/.pyenv"
    # set your path
    libsh__add_path "pre" "$PYENV_ROOT/bin"
    # eval
    eval "$(pyenv init --path)"
fi

# if [ -d $HOME/.pyenv ]; then
#     #if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
#     eval "$(pyenv init -)"
#     libsh__debug "FN +Loaded pyenv init"
# fi
