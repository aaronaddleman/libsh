# nvm
nvm_install() {
    command -v nvm > /dev/null
    [ "${?}" = "0" ] || brew install nvm
    [[ -d $HOME/.nvm ]] || mkdir $HOME/.nvm
}
