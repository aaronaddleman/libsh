
curl -SsL https://github.com/cdr/code-server/releases/download/3.1.1/code-server-3.1.1-linux-x86_64.tar.gz | tar -C /usr/local/lib -xzf -
mv /usr/local/lib/code-server* /usr/local/lib/code-server
#/usr/local/lib/code-server/code-server --host 0.0.0.0 --cert &

if [ -n "${JUPYTER_RSTUDIO}" ]; then
    sudo apt update
    sudo apt-get -y install gdebi-core
    sudo apt-get -y install libssl1.0.0
    wget https://download2.rstudio.org/server/trusty/amd64/rstudio-server-1.2.5042-amd64.deb
    sudo gdebi rstudio-server-1.2.5042-amd64.deb
    cat <<- EOF > /etc/rstudio/rserver.conf
# Server Configuration File

rsession-which-r=/opt/conda/bin/R
EOF
    sudo rstudio-server start
fi

