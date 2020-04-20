[ -d $HOME/go ] && export GOROOT="$HOME/go" || libsh__debug "x..could not find $HOME/go"
[ -d /usr/lib/go ] && export GOROOT="/usr/lib/go" || libsh__debug "x..unable to find /usr/lib/go"
[ -d /usr/local/go ] && export GOROOT="/usr/local/go" || libsh__debug "x..unable to find /usr/local/go"
[ -d $GOROOT ] && export PATH=$PATH:$GOROOT/bin
