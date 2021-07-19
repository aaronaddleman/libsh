if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    libsh__debug "FN +Loaded pyenv init"
fi

pyenv_install() {
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}
