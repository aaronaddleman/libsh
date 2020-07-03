# set your python workon home or use default
[ -n "$LIBSH_PYTHON_WORKON_HOME" ] && \
    export WORKON_HOME=${${LIBSH_PYTHON_WORKON_HOME}-$HOME/.virtualenvs} && \
    export PROJECT_HOME=${HOME}/src
