[ -d $HOME/.cargo ] && libsh__add_path "pre" "$HOME/.cargo/bin"
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
