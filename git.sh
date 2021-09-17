#!/usr/bin/env bash

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
    libsh__debug "Missing file for git commit template"

[ ! -z $ENABLE_GIT_COMMIT_TEMLPATE ] && git config --global commit.template $ENABLE_GIT_COMMIT_TEMPLATE

git_remove_local_merged() {
    local help=$(cat <<HELP
## git_remove_local_merged


Delete local branches that are already merged. This excludes the branch pattern that is provided in arg 1.

Eg.

...shell
git_remove_local_not_merged "|main"
git_remove_local_not_merged "|main|dev"
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    [[ ! -z "${1}" ]] || libsh__exit_with_message "ERR" "Missing list of regex for branches to ignore"
    git branch --merged | egrep -v "(^\*${1})" | xargs git branch -d
}

#
# git clone based on repo url
#
git_clone() {
    local help=$(cat <<HELP
## git_clone

Git clone to a subdir based on the projects remote domain

Eg.

...shell
# clone the project of https://github.com/aaronaddleman/libsh
# this would result in being cloned to
# $HOME/$LIBSH_SRC_DIR/github.com/aaronaddleman/libsh
#
git_clone https://github.com/aaronaddleman/libsh
...

HELP
)
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    libsh__debug "exec: git_clone"
    [ -z $LIBSH_SRC_DIR ] && libsh__exit_with_message "ERR" "Please define LIBSH_SRC_DIR in $HOME/.libshrc"
    libsh__debug "_var: LIBSH_SRC_DIR = $LIBSH_SRC_DIR"

    # assign arg to repo variable
    local repo=${1}
    libsh__debug "_var: repo = $repo"

    # test remote repo arg starts with https
    [[ $repo = https* ]] || libsh__exit_with_message "ERR" "Repo must start with https"

    # try to find dir of arg
    local domain=$(echo "$repo" | awk -F/ '{print $3}')
    libsh__debug "_var: domain = $domain"

    # try to find the name of the project
    local project=$(echo "$repo" | awk -F/ '{print $5}' | sed -e 's/\.git//g')
    libsh__debug "_var: project = $project"

    # try cloning
    local git_clone_args="$repo $LIBSH_SRC_DIR/$domain/$project"
    libsh__debug "_args: $git_clone_args"
    libsh__debug "_exec: git clone $git_clone_args"
    git clone $repo $LIBSH_SRC_DIR/$domain/$org/$project
}

