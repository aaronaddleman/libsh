# GOENV
[ -d $HOME/.goenv ] && export GOENV_ROOT="$HOME/.goenv"
[ -d $HOME/.goenv ] && libsh__add_path "pre" "$GOENV_ROOT/bin"
[ -z $GOENV_ROOT ] || eval "$(goenv init -)"

# GOPATH
[ -d $HOME/go ] && export GOPATH="$HOME/go" || libsh__debug "x..could not find $HOME/go"
[ -d $HOME/go/bin ] && libsh__add_path "post" "$HOME/go/bin"

# GOROOT
[ -d /usr/lib/go ] && export GOROOT="/usr/lib/go" || libsh__debug "- unable to find /usr/lib/go"
[ -d /usr/local/go ] && export GOROOT="/usr/local/go" || libsh__debug "- unable to find /usr/local/go"
[ -d $GOROOT ] && libsh__add_path "post" "$GOROOT/bin"
