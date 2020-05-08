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
	         -e NB_USER=$USER \
           -e NB_GID=$(id -u) \
	         -e JUPYTER_ENABLE_LAB=yes \
	         -e GRANT_SUDO=yes \
	         -e GEN_CERT=yes \
           -e CHOWN_HOME=yes \
           -v "${LIBSH_HOME}/jupyterlabs_boot.sh":/usr/local/bin/before-notebook.d/jupyter.sh \
           -v "${HOME}/.libshrc":/home/$USER/.libshrc \
           -v "${LIBSH_HOME}":/home/$USER/libsh \
	         -v "${workdir}":/home/$USER/work \
           jupyter/base-notebook
}

jupyter_labs_install_go() {
    local help=$(cat <<HELP
## jupyter_labs_install_go

Installs a version of Go for Jupyter.

Meant to run inside Jupyter for installing Go support.

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0

    sudo apt-get update && apt-get install -y --no-install-recommends \
        g++ \
        gcc \
        libc6-dev \
        make \
        pkg-config

    export GOLANG_VERSION=1.9
    #export LGOPATH=/lgo
    #mkdir -p $LGOPATH

    set -eux; \
    # this "case" statement is generated via "update.sh"
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
        amd64) goRelArch='linux-amd64'; goRelSha256='d70eadefce8e160638a9a6db97f7192d8463069ab33138893ad3bf31b0650a79' ;; \
        armhf) goRelArch='linux-armv6l'; goRelSha256='b9d16a8eb1f7b8fdadd27232f6300aa8b4427e5e4cb148c4be4089db8fb56429' ;; \
        arm64) goRelArch='linux-arm64'; goRelSha256='98a42b9b8d3bacbcc6351a1e39af52eff582d0bc3ac804cd5a97ce497dd84026' ;; \
        i386) goRelArch='linux-386'; goRelSha256='e74f2f37b43b9b1bcf18008a11e0efb8921b41dff399a4f48ac09a4f25729881' ;; \
        ppc64el) goRelArch='linux-ppc64le'; goRelSha256='23291935a299fdfde4b6a988ce3faa0c7a498aab6d56bbafbf1e7476468529a3' ;; \
        s390x) goRelArch='linux-s390x'; goRelSha256='a67ef820ef8cfecc8d68c69dd5bf513aaf647c09b6605570af425bf5fe8a32f0' ;; \
        *) goRelArch='src'; goRelSha256='042fba357210816160341f1002440550e952eb12678f7c9e7e9d389437942550'; \
            echo >&2; echo >&2 "warning: current architecture ($dpkgArch) does not have a corresponding Go binary release; will be building from source"; echo >&2 ;; \
    esac; \
    \
    url="https://golang.org/dl/go${GOLANG_VERSION}.${goRelArch}.tar.gz"; \
    wget -O go.tgz "$url"; \
    echo "${goRelSha256} *go.tgz" | sha256sum -c -; \
    sudo tar -C /usr/local -xzf go.tgz; \
    rm go.tgz; \
    if [ "$goRelArch" = 'src' ]; then \
        echo >&2; \
        echo >&2 'error: UNIMPLEMENTED'; \
        echo >&2 'TODO install golang-any from jessie-backports for GOROOT_BOOTSTRAP (and uninstall after build)'; \
        echo >&2; \
        exit 1; \
    fi; \
    \
    export PATH="/usr/local/go/bin:$PATH"; \
    go version

    #ENV GOPATH /go
    #ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
    #RUN mkdir -p $GOPATH
    #RUN chown -R $USER:$(id -u) $GOPATH
    #RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
}

jupyter_labs_install_lgo() {
    local help=$(cat <<HELP
## jupyter_labs_install_go

Meant to run inside Jupyter for installing Go Kernel support

!!! UNDER DEVELOPMENT

Current issues:

1. Takes a long time to install
1. Kernel not allowed to be used. Might be due to Go not in /home/$USER/go dir

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0

    sudo apt install -y git gcc pkg-config libzmq3-dev
    go get github.com/yunabe/lgo/cmd/lgo && go get -d github.com/yunabe/lgo/cmd/lgo-internal
    go get -u github.com/nfnt/resize
    go get -u gonum.org/v1/plot/...
    go get -u github.com/wcharczuk/go-chart
    export PATH=$PATH:$HOME/go/bin
    export LGOPATH=$HOME/lgo
    mkdir $LGOPATH
    lgo install
    lgo installpkg github.com/nfnt/resize
    lgo installpkg gonum.org/v1/gonum/...
    lgo installpkg gonum.org/v1/plot/...
    lgo installpkg github.com/wcharczuk/go-chart
    python $HOME/go/src/github.com/yunabe/lgo/bin/install_kernel
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
}
