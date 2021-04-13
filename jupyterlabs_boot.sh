# do things before the notebook is created
sudo apt update && apt install -y curl net-tools zsh git unzip
# set zsh for the user
sudo chsh -s /usr/bin/zsh ${NB_USER}
# make a bin dir
sudo -u ${NB_USER} mkdir -p /home/${NB_USER}/.local/bin
# make a config dir
sudo -u ${NB_USER} mkdir -p /home/${NB_USER}/.config/libsh
# install code-server
curl -SsL https://github.com/cdr/code-server/releases/download/3.4.1/code-server-3.4.1-linux-x86_64.tar.gz | tar -C /usr/local/lib -xzf -
mv /usr/local/lib/code-server* /usr/local/lib/code-server
sudo -u ${NB_USER} -H sh -c "/usr/local/lib/code-server/bin/code-server --host 0.0.0.0 --cert --auth none" &
