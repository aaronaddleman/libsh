# do things before the notebook is created
sudo apt update && apt install -y curl net-tools
curl -SsL https://github.com/cdr/code-server/releases/download/3.1.1/code-server-3.1.1-linux-x86_64.tar.gz | tar -C /usr/local/lib -xzf -
mv /usr/local/lib/code-server* /usr/local/lib/code-server
sudo -u ${NB_USER} -H sh -c "/usr/local/lib/code-server/code-server --host 0.0.0.0 --cert" &
