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
