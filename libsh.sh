#
# LIBSH
#

# This is the main file of libsh where everything begins. To use
# this environment, source this file and the defaults found in
# $LIBSH_HOME/.libsh will be used.
#
# To override $LIBSH_HOME/.libsh and load only when you need, create a
# $HOME/.libsh file. Best way to start is by copying the default
# file located at:
#
# $LIBSH_HOME/.libsh

#############################################
# = below this line is where libsh starts = #
#############################################

#
# Find out where this file lives and call it home
#
case $SHELL in
    *zsh)
        export LIBSH_HOME=${0:a:h}
        ;;
    *bash)
        export LIBSH_HOME=$(dirname $BASH_SOURCE[@])
        ;;
    *)
        echo "Failed. Shell of \"$SHELL\" not supported" && kill -INT $$
esac

#
# Load libsh_utils.sh
#
source $LIBSH_HOME/libsh_utils.sh

#
# define custom Functions and default Functions
#
source $LIBSH_HOME/.libshrc && libsh__debug "loaded $LIBSH_HOME/.libshrc"
# if custom libshrc exists, load that
[[ -f "$HOME/.libshrc" ]] && source $HOME/.libshrc && libsh__debug "loaded $HOME/.libshrc"

libsh_fn=("${libsh_fn_custom[@]}" "${libsh_fn_defaults[@]}")
libsh__debug "fn custom -> ${libsh_fn_custom[*]}"
libsh__debug "fn defaults > ${libsh_fn_defaults[*]}"

#
# load all of the functions
#
libsh__load() {
    local mode=$1

    if [ ${#libsh_fn[@]} ]; then
        for fn in ${libsh_fn[@]}
        do
            # debug and show what we load for ${FN}.sh
            [[ "${mode}" == "fn" ]] && libsh__debug "FN  Trying to load '${LIBSH_HOME}/${fn}.sh'"
            # var name
            local fn_varname="LIBSH_status_fn_${fn}"
            # load the FNs
            [[ "${mode}" == "fn" ]] && \
                [ -f ${LIBSH_HOME}/${fn}.sh ] && \
                source ${LIBSH_HOME}/${fn}.sh && \
                printf -v "$fn_varname" '%s' "loaded" && \
                libsh__debug "FN  Loaded '${LIBSH_HOME}/${fn}.sh'"


            # debug and show what we load for ${FN}.env.sh
            [[ "${mode}" == "env" ]] && libsh__debug "ENV  Trying to load '${LIBSH_HOME}/${fn}.env.sh'"
            # var name
            local env_varname="LIBSH_status_env_${fn}"
            # load the FNs envs
            [[ "${mode}" == "env" ]] && [ -f ${LIBSH_HOME}/${fn}.env.sh ] && source ${LIBSH_HOME}/${fn}.env.sh && printf -v "$env_varname" '%s' "loaded" && libsh__debug "ENV  Loading '${LIBSH_HOME}/${fn}.env.sh'"
        done
        export LIBSH_STATUS=t
    else
        export LIBSH_STATUS=f
        libsh__exit_with_message "ERR" "Something went wrong in loading libsh."
    fi

    if [ ${LIBSH_CHECK_BY_DATE} ]; then
        libsh__check_by_date
    fi
}

# if we get an arg, load the things!
[ -z "${1}" ] && libsh__exit_with_message "ERR" "I need to know if you want to load 'fn' or 'env'."
[ -z "${1}" ] || libsh__load ${1}