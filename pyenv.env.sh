if [ -d $HOME/.pyenv ]; then
    # set the PYENV_ROOT
    export PYENV_ROOT="$HOME/.pyenv"
    # set your path
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

if [ -d $HOME/.pyenv ]; then
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
    eval "$(pyenv init -)"
    libsh__debug "FN +Loaded pyenv init"
fi
