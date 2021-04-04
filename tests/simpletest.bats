#!/usr/bin/env bats

function setup() {
  source ${GITHUB_WORKSPACE}/.libshrc_bats
  source ${GITHUB_WORKSPACE}/libsh.sh "env"
  source ${GITHUB_WORKSPACE}/libsh.sh "fn"
}

@test "status loaded" {
  [ "$LIBSH_STATUS" = "t" ]
  [ "$LIBSH_status_env_custom" = "loaded" ]
  [ "$LIBSH_status_env_paths" = "loaded" ]
  [ "$LIBSH_status_env_python" = "loaded" ]
  [ "$LIBSH_status_fn_custom" = "loaded" ]
  [ "$LIBSH_status_fn_aws" = "loaded" ]
  [ "$LIBSH_status_fn_figlet" = "loaded" ]
  [ "$LIBSH_status_fn_git" = "loaded" ]
  [ "$LIBSH_status_fn_go" = "loaded" ]
  [ "$LIBSH_status_fn_jupyter" = "loaded" ]
  [ "$LIBSH_status_fn_options" = "loaded" ]
  [ "$LIBSH_status_fn_pyenv" = "loaded" ]
  [ "$LIBSH_status_fn_python" = "loaded" ]
  [ "$LIBSH_status_fn_rvm" = "loaded" ]
  [ "$LIBSH_status_fn_sh_aliases" = "loaded" ]
  [ "$LIBSH_status_fn_ssh" = "loaded" ]
  [ "$LIBSH_status_fn_vault" = "loaded" ]
}

@test "installing goenv" {
  go_install_goenv
  [ -d $HOME/.goenv ]
  libsh__reload
  source /code/.libshrc_bats
  #[ "$GOENV_ROOT" = "$HOME/.goenv" ]
}