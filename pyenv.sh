if [ -d $HOME/.pyenv ]; then
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
    command -v pyenv > /dev/null
    eval "$(pyenv init -)"
    libsh__debug "FN +Loaded pyenv init"
fi
