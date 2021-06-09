#!/usr/bin/env bash

# load any additional settings
{
    local dirlist=($(ls $HOME/.sh.d/*.fn.sh))
} &> /dev/null
[ $? = 0 ] && \
    for file in ${dirlist[*]}
    do
        libsh__debug "FN  custom: Trying to load $file"
        source ${file}
    done
