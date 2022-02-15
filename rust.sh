rust_install() {
    local help=$(cat <<HELP
## rust_install

Helps install rust for the detected os
...shell
rust_install
...

Other installation methods:

https://forge.rust-lang.org/infra/other-installation-methods.html

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    if [[ $OSTYPE == 'darwin'* ]]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
}
