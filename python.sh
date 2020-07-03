python_install_virtualenv() {
    [ $(command -v pip) ] && pip install virtualenv
}

python_install_virtualenvwrapper() {
    [ $(command -v pip) ] && pip install virtualenvwrapper
}
