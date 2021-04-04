# exit with problem and not exit shell
libsh__exit_with_message() {
    echo "$1: $2"
    kill -INT $$
}

libsh__exit_without_message() {
    kill -INT $$
}

libsh__help() {
    [[ "${1}" =~ "-help"$ ]] && libsh__help libsh__continue_msg
    args=$1
    sed -n "/^# $args$/,/^$args() {/p;/^$args()/q" $LIBSH_HOME/* | sed '$d'
    libsh__exit_without_message
}

libsh__fn() {
    \grep --no-filename -e "() {$" $LIBSH_HOME/*.sh | \grep -v -E "(^#.*|^libsh__.*|.*_pre|.*_post$|.*_validate_env)" | \sed -e 's/() {//g' | sort
}

# libsh__continue_msg
#
# Prompt user with Y/N to continue. Function will return 0 if yes
# or 1 if no.
libsh__continue_msg() {
    [[ "${1}" =~ "-help"$ ]] && libsh__help libsh__continue_msg
    while true; do
        read -p "Continue (y/Y/Yes/n/N/No)?" yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done

}

# libsh__debug
#
# Print a debug message only if $LIBSH_DEBUG variable is defined.
# It does not matter what the value is.
#
# Eg.
#
# libsh_debug "Message that something happened"
libsh__debug() {
    [[ "${1}" =~ "-help"$ ]] && libsh__help libsh__debug
    # print msg if debug is turned on
    MSG=$1
    [ -z "$LIBSH_DEBUG" ] || echo -e "$MSG" >> $LIBSH_DEBUG_LOGFILE
}

libsh__help_doc() {
    echo $1 | sed -e 's/\.\.\./```/g'
    echo -e "\n"
    echo -e "\n"
}

# libsh__random_string
libsh__random_string() {
    local help=$(cat <<HELP
## Print a random string
HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help"
    case "$OSTYPE" in
         darwin*)
             LC_CTYPE=C tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | head -c 32 | xargs
         ;;
         *)
             tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1
    esac
}

libsh__mask() {
    local help=$(cat <<HELP
## libsh_mask

Mask a string leaving out the last n chars. Defaults to 3 characters.

...shell
# mask all but 1 character
libsh__mask "1234567890" 1
*********0

# mask all but 3 charactes
libsh__mask "1234567890"
*******890
...
HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help"
    local n=${2-3}               # number of chars to leave
    local a="${1:0:${#1}-n}"     # take all but the last n chars
    local b="${1:${#1}-n}"       # take the final n chars
    printf "%s%s\n" "${a//?/*}" "$b"   # substitute a with asterisks
}

libsh__add_path() {
    local position=$1
    local path_to_add=$2
    libsh__debug "+ libsh__add_path $position $path_to_add"
    # does path already exist?
    [[ "$PATH" != *"$path_to_add"* ]] && local path_missing=t || libsh__debug "WRN  path already exists: $path_to_add"
    # pre
    [ ! -z $path_missing ] && [[ "${position}" == "pre" ]] && PATH="${path_to_add}:${PATH}"
    # post
    [ ! -z $path_missing ] && [[ "${position}" == "post" ]] && PATH="${PATH}:${path_to_add}"
}
