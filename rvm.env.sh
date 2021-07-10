#!/usr/bin/env bash

[ -d $HOME/.rvm/bin ] && libsh__add_path "pre" "$HOME/.rvm/bin"

if [[ -d $HOME/.rvm && ! -z ${LIBSH_ENABLE_RVM} ]]; then
    source $HOME/.rvm/scripts/rvm
fi
