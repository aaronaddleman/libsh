# https://github.com/jdxcode/rtx/
rtx_install() {
    [[ ! -d $HOME/bin ]] && mkdir -p $HOME/bin
    [[ ! -f $HOME/bin/rtx ]] && curl https://rtx.pub/rtx-latest-macos-arm64 > ~/bin/rtx
    chmod +x ~/bin/rtx
}
