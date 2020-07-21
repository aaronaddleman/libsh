[ -d $HOME/.local/bin ] && libsh__add_path "pre" "$HOME/.local/bin"
[ ! -z $LIBSH_CDPATH ] && export CDPATH=$LIBSH_CDPATH
