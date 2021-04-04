1password_install_cli() {
    [[ "$(uname)" == "Darwin" ]] && brew install 1password-cli && libsh__exit_with_message "Installed" "1password-cli"
    [[ "$(uname)" == "Linux" ]] && export LIBSH_OSLINUX=t
    [[ "${LIBSH_OSLINUX}" == "t" ]] && wget -O /tmp/op.zip https://cache.agilebits.com/dist/1P/op/pkg/v1.8.0/op_linux_386_v1.8.0.zip && unzip /tmp/op.zip -d /usr/local/bin
}