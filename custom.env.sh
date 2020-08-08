# load any additional settings
{
    local dirlist=($(ls $HOME/.sh.d/*.env.sh))
} &> /dev/null
[ $? = 0 ] && \
    for file in ${dirlist[*]}
    do
        libsh__debug "ENV  Trying to load $file"
        source ${file}
    done
