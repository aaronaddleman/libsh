# GOENV
[ -d $HOME/.goenv ] && export GOENV_ROOT="$HOME/.goenv"
[ -d $HOME/.goenv ] && libsh__add_path "pre" "$GOENV_ROOT/bin"
# [ -d $GOPATH/bin ] || mkdir $GOPATH/bin

# let GOENV manage paths
[ -d $HOME/.goenv ] && libsh__add_path "pre" "$GOROOT/bin"
[ -d $HOME/.goenv ] && libsh__add_path "post" "$GOPATH/bin"
[ -d $HOME/.goenv ] && eval "$(goenv init -)"

# GOPATH
## this will not conflict with goenv because the destination for 
## for goenv is $HOME/go/VER/bin
[ -d $HOME/go -a ! -d $HOME/.goenv ] && export GOPATH="$HOME/go" || libsh__debug "x..could not find $HOME/go"
[ -d $HOME/go/bin ] && libsh__add_path "post" "$HOME/go/bin"

# GOROOT
[ -d /usr/lib/go ] && export GOROOT="/usr/lib/go" || libsh__debug "- unable to find /usr/lib/go"
[ -d /usr/local/go ] && export GOROOT="/usr/local/go" || libsh__debug "- unable to find /usr/local/go"
[ -d $GOROOT ] && libsh__add_path "post" "$GOROOT/bin"
