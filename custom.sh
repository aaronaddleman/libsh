# load any additional settings
{
    local dirlist=($(ls $HOME/.sh.d/*.fn.sh))
} &> /dev/null
[ $? = 0 ] && \
    for file in ${dirlist[*]}
    do
        source ${file}
    done
