terragrunt_install_tgenv() {
    local help=$(cat <<HELP
## terragrunt_install_tgenv

To install tgenv and help manage Terragrunt versions.
This will get installed to your '$HOME'/.tgenv directory. Once installed, reload your
shell environment.

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    [ ! -d $HOME/.tgenv ] && git clone https://github.com/cunymatthieu/tgenv.git $HOME/.tgenv
}

command -v terragrunt > /dev/null
[ $? -eq 0 ] && alias tg="terragrunt"
