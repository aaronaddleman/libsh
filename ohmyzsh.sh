ohmyzsh_validate() {
    [ -z $ZSH_CUSTOM ] && export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
}

ohmyzsh_install() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

ohmyzsh_install_spaceship() {
    ohmyzsh_validate
    [ -d $ZSH_CUSTOM/themes/spaceship-prompt ] || git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    [ -L $ZSH_CUSTOM/themes/spaceship.zsh-theme ] || ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
}

ohmyzsh_like_fish() {
    ohmyzsh_validate
    [ -d $ZSH_CUSTOM/plugins/zsh-autosuggestion ] || git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    [ -d $ZSH_CUSTOM/plugins/zsh-history-substring-search ] || git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
    [ -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "add these to .zshrc: "
    echo "plugins = ( [plugins...] zsh-autosuggestions history-substring-search zsh-syntax-highlighting)"
}
