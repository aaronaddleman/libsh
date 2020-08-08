jupyter_labs_docker_base() {
    local help=$(cat <<HELP
## jupyter_labs_docker_base

Runs jupyter labs base image with many options
that I think are helpful:

1. Enabling jupyter labs
1. Granting sudo
1. Setting user and group to current user
1. Generating a certificate
1. Running jupyterlabs_boot.sh with VS Code server
1. Mounting libsh as a volume
1. Using \$1 as your workdir

...shell
juypter_labs_docker_base path/to/work/on
...

Your path/to/work/on is mounted to /home/$USER/work
HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    local workdir=${1}
    [ -z ${workdir} ] && libsh__exit_with_message "MIA" "Need workdir for arg 1"
    docker run --rm \
           -p 8888:8888 \
           -p 8080:8080 \
           --user=root \
           -e SHELL=/usr/bin/zsh \
           -e NB_USER=$USER \
           -e NB_GID=$(id -u) \
           -e JUPYTER_ENABLE_LAB=yes \
           -e GRANT_SUDO=yes \
           -e GEN_CERT=yes \
           -e CHOWN_HOME=yes \
           -v "${LIBSH_HOME}/jupyterlabs_boot.sh":/usr/local/bin/before-notebook.d/jupyter.sh \
           -v "${HOME}/.libshrc":/home/$USER/.libshrc \
           -v "${LIBSH_HOME}/.bash_profile":/home/$USER/.bash_profile \
           -v "${LIBSH_HOME}/.zshrc":/home/$USER/.zshrc \
           -v "${LIBSH_HOME}/.zshenv":/home/$USER/.zshenv \
           -v "${LIBSH_HOME}":/home/$USER/src/libsh \
           -v "${workdir}":/home/$USER/work \
           jupyter/base-notebook
}


jupyter_labs_install_codeserver() {
    local help=$(cat <<HELP
## jupyter_labs_install_codeserver

Installs a the "code-server" to /usr/local/lib
Adds a link of /usr/local/bin/code-server to /usr/local/lib/code-server/code-server

Meant to run inside Jupyter for running an instance of "code-server"

To start the process and listen on all interfaces:

...shell
/usr/local/bin/code-server --host 0.0.0.0
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0

    sudo apt install -y curl
    sudo curl -SsL https://github.com/cdr/code-server/releases/download/3.1.1/code-server-3.1.1-linux-x86_64.tar.gz | sudo tar -C /usr/local/lib -xzf -
    sudo ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server
}

jupyter_labs_simple() {
    local help=$(cat <<HELP
## jupyter_labs_vscode

Start a jupyterlabs with vscode as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

...shell
jupyter_labs_simple /path/to/your/project docker_img
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    unset $(env | sed -n 's/^\(JUPYTER_.*\)=.*/\1/p')
    export JUPYTER_IMAGE=${2}
    export JUPYTER_WORKDIR=$1
    export JUPYTER_ENABLE_LAB=t
    export JUPYTER_GRANT_SUDO=yes
    export JUPYTER_RUN_ROOT=t
    env | grep JUPYTER_
    jupyter_launch $JUPYTER_WORKDIR
}

jupyter_labs_datasci_rstudio() {
    local help=$(cat <<HELP
## jupyter_datasci_rstudio

Start a jupyterlabs with datascience and rstudio as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

...shell
jupyter_labs_datasci_rstudio /path/to/your/project
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    unset $(env | sed -n 's/^\(JUPYTER_.*\)=.*/\1/p')
    export JUPYTER_WORKDIR=$1
    export JUPYTER_IMAGE=jupyter/datascience-notebook
    export JUPYTER_RSTUDIO=yes
    export JUPYTER_ENABLE_LAB=t
    export JUPYTER_NB_USER=$USER
    export JUPYTER_GRANT_SUDO=yes
    export JUPYTER_RUN_ROOT=t
    export JUPYTER_BEFORE=$LIBSH_HOME/scripts/install.sh
    export JUPYTER_DOTDIR=$HOME/src/jupyterlabs_settings/aaronaddleman
    env | grep JUPYTER_
    jupyter_launch $JUPYTER_WORKDIR
}

jupyter_labs_vscode() {
    local help=$(cat <<HELP
## jupyter_labs_vscode

Start a jupyterlabs with vscode as well. Takes one arg of your workdir.
Additional vars are available in the jupyer_launch function.

...shell
jupyter_labs_vscode /path/to/your/project docker_img_with_curl_installed
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    unset $(env | sed -n 's/^\(JUPYTER_.*\)=.*/\1/p')
    export JUPYTER_WORKDIR=$1
    export JUPYTER_IMAGE=${2}
    export JUPYTER_ENABLE_LAB=t
    export JUPYTER_NB_USER=$USER
    export JUPYTER_GRANT_SUDO=yes
    export JUPYTER_RUN_ROOT=t
    export JUPYTER_BEFORE=$LIBSH_HOME/scripts/install.sh
    export JUPYTER_DOTDIR=$HOME/src/jupyterlabs_settings/aaronaddleman
    env | grep JUPYTER_
    jupyter_launch $JUPYTER_WORKDIR
}

jupyter_launch() {
    local help=$(cat <<HELP
## jupyter_launch

Start a jupyter server.

To set additional args you can do the following:

...shell
export JUPYTER_ENABLE_LAB=t
export JUPYTER_CHOWN_HOME=t
export JUPYTER_BEFORE=/file/to/run/before/book.sh
export JUPYTER_CHOWN_EXTRA="/paths,/to,/also/chown"
export JUPYTER_CHOWN_HOME=t
export JUPYTER_CHOWN_HOME_OPTS="-R 770"
export JUPYTER_ENABLE_LAB=t
export JUPYTER_GRANT_SUDO=yes
export JUPYTER_NB_USER=$USER
export JUPYTER_OPTS="-e OtherOpt=Value -e MoreOpts=MoreThings"
export JUPYTER_RUN_ROOT=t
export JUPYTER_WORKDIR="/path/to/project"

jupyter_launch
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    set -x
    set -- docker run -it -p 8888:8888 -p 8080:8080 -p 8787:8787 -e USE_SSL=yes -e GEN_CERT=yes
    [ -f "$LIBSH_HOME/scripts/jupyter_default.sh" ] && \
      set -- "$@" -v "$LIBSH_HOME/scripts/jupyter_default.sh:/usr/local/bin/before-notebook.d/jupyter_default.sh"
    [ -n "$JUPYTER_BEFORE" ] && set -- "$@" -v "$JUPYTER_BEFORE":/usr/local/bin/before-notebook.d/boot.sh
    [ -n "$JUPYTER_CHOWN_EXTRA" ] && set -- "$@" -e CHOWN_HOME_EXTRA=${JUPYTER_CHOWN_HOME_EXTRA}
    [ -n "$JUPYTER_CHOWN_HOME" ] && set -- "$@" -e CHOWN_HOME=yes
    [ -n "$JUPYTER_CHOWN_HOME_OPTS" ] && set -- "$@" -e CHOWN_HOME_OPTS=${JUPYTER_CHOWN_HOME_OPTS}
    [ -n "$JUPYTER_ENABLE_LAB" ] && set -- "$@" -e JUPYTER_ENABLE_LAB=yes
    [ -n "$JUPYTER_GRANT_SUDO" ] && set -- "$@" -e GRANT_SUDO=yes
    [ -n "$JUPYTER_NB_USER" ] && set -- "$@" -e NB_USER=${JUPYTER_NB_USER}
    [ -n "$JUPYTER_PORTS" ] && set -- "$@" ${JUPYTER_PORTS}
    [ -n "$JUPYTER_RUN_ROOT" ] && set -- "$@" --user=root
    [ -n "$JUPYTER_WORKDIR" ] && set -- "$@" -v "$JUPYTER_WORKDIR":/data/user/${JUPYTER_NB_USER-jovyan}/shared
    [ -n "$JUPYTER_DOTDIR" ] && set -- "$@" -v "$JUYPYTER_DOTDIR":/data/user/{$JUYPYTER_NB_USER-jovyan}/.jupyter
    set -- "$@" "${JUPYTER_IMAGE-jupyter/base-notebook}"
    "$@"
    set +x
}
