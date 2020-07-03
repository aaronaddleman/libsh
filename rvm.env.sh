[ -d $HOME/.rvm/bin ] && export PATH=$HOME/.rvm/bin:$PATH

if [[ -d $HOME/.rvm && ! -z ${LIBSH_ENABLE_RVM} ]]; then
    source $HOME/.rvm/scripts/rvm
fi
