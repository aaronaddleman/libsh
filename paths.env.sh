#!/usr/bin/env bash

[ -d $HOME/.local/bin ] && libsh__add_path "pre" "$HOME/.local/bin"
[ -d /usr/local/bin ] && libsh__add_path "pre" "/usr/local/bin"
[ ! -z $LIBSH_CDPATH ] && export CDPATH=$LIBSH_CDPATH
