# if you have .goenv installed, init
#[ -d $HOME/.goenv ] && export GOENV_ROOT="$HOME/.goenv"
#[ -d $HOME/.goenv ] && libsh__add_path "pre" "$GOENV_ROOT/bin"
[ ! -z $LIBSH_GOENV_MGMT_PATH ] && libsh__add_path "pre" "$GOROOT/bin"
[ ! -z $LIBSH_GOENV_MGMT_PATH ] && libsh__add_path "post" "$GOPATH/bin"
[ -d $HOME/.goenv ] && eval "$(goenv init -)"

go_validate_env() {
    command -v git > /dev/null
    [ "${?}" = "0" ] || libsh__exit_with_message "Problem" "git command not found"
}

go_install_for_spacemacs() {
    local help=$(cat <<HELP
## go_install_for_spacemacs

Installs all of the packages needed for doing
Go development.
HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    if [ "$(command -v go 2>/dev/null)" ]; then
        go get -u -v github.com/mdempsky/gocode
        go get -u -v github.com/rogpeppe/godef
        go get -u -v golang.org/x/tools/cmd/guru
        go get -u -v golang.org/x/tools/cmd/gorename
        go get -u -v golang.org/x/tools/cmd/goimports
        go get -u -v golang.org/x/tools/cmd/godoc
        go get -u -v github.com/zmb3/gogetdoc
        go get -u -v github.com/cweill/gotests/...
        go get -u github.com/haya14busa/gopkgs/cmd/gopkgs
        go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
        go get -u github.com/josharian/impl
        go get -u -v github.com/alecthomas/gometalinter
        gometalinter --install --update
    fi
}

go_install_for_doom() {
    local help=$(cat <<HELP
## go_install_for_spacemacs

Installs all of the packages needed for doing
Go development.
HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    if [ "$(command -v go 2>/dev/null)" ]; then
        go get -u github.com/x-motemen/gore/cmd/gore
        go get -u github.com/stamblerre/gocode
        go get -u golang.org/x/tools/cmd/godoc
        go get -u golang.org/x/tools/cmd/goimports
        go get -u golang.org/x/tools/cmd/gorename
        go get -u golang.org/x/tools/cmd/guru
        go get -u github.com/cweill/gotests/...
        go get -u github.com/fatih/gomodifytags
        GO111MODULE=on go install golang.org/x/tools/gopls@latest
    fi
}

go_install_goenv() {
    go_validate_env
    git clone https://github.com/syndbg/goenv.git ~/.goenv
}
