bash_spacemacs() {
    command -v npm > /dev/null
    [ "$?" = "0" ] && npm i -g bash-language-server || libsh__exit_with_message "ERR missing npm command"
    command -v shellcheck > /dev/null
    [ "$?" = "0" ] || brew install shellcheck
    command -v bashate > /dev/null
    [ "$?" = "0" ] || pip install bashate
    cat << HEREDOC

LIBSH_MSG

To enable the lsp backend. Add the following to your .spacemacs:

(shell-scripts :variables shell-scripts-backend 'lsp)

HEREDOC
}

