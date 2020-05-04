if [ -d $HOME/.pyenv ]; then
    # set the PYENV_ROOT
    export PYENV_ROOT="$HOME/.pyenv"
    # set your path
    export PATH="$PYENV_ROOT/bin:$PATH"
fi
