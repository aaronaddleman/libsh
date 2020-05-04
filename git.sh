#
# set git auto correct
#
# eg: git_autocorrect 80
#
# will set the autocorrect for 8.0 seconds
git_autocorrect() {
    local help=$(cat <<HELP
## git_autocorrect

Enable git config help.autocorrect globally. This will help with command
spelling. The timeout allows you to cancel the command incase git still
gets it wrong.

Eg.

...shell
# set the autocorrect timeout for 8.0 seconds
git_autocorrect 80
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    [[ -z "${1}" ]] && libsh__exit_with_message "ERR" "Missing timeout for arg 1"
    git config --global help.autocorrect $1
}

#
# set git commit template
#
[[ ! -z ${ENABLE_GIT_COMMIT_TEMPLATE} && -f $ENABLE_GIT_COMMIT_TEMPLATE ]] || \
    libsh__exit_with_message "ERR" "Missing file for git commit template"

[ ! -z $ENABLE_GIT_COMMIT_TEMLPATE ] && git config --global commit.template $ENABLE_GIT_COMMIT_TEMPLATE

git_remove_local_not_master() {
    git branch | grep -v "master" | xargs git branch -D
}
