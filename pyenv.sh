if [ -d $HOME/.pyenv ]; then
    # execute the eval
    eval "$(pyenv init -)"
    libsh__debug "FN +Loaded pyenv init"
fi

pyenv_install() {
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}
