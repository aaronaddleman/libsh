if [ -d $HOME/.pyenv ]; then
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
    eval "$(pyenv init -)"
fi
