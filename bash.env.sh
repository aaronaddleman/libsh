#!/usr/bin/env bash

# load any additional settings
#[ -d $HOME/.bash.d ] && ls $HOME/.bash.d/*.env.sh 1> /dev/null 2>&1

#[ "$?" == "0" ] && source $HOME/.bash.d/*.env.sh

local num_of_env_sh=$(find $HOME/.bash.d -maxdepth 1 -type f  -name '*.env.sh' | wc -l)
libsh__debug "INFO Found ${num_of_env_sh} files matching $HOME/.bash.d/*.env.sh ."
[ "${num_of_env_sh}" -gt 0 ] && source $HOME/.bash.d/*.env.sh
