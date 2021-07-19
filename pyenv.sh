if [ -d $HOME/.pyenv ]; then
    eval "$(pyenv init --path)"
    # execute the eval
    eval "$(pyenv init -)"
    libsh__debug "FN +Loaded pyenv init"
fi

pyenv_install() {
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}
