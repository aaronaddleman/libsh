vscode_keyrepeat_enable() {
    local help=$(cat <<HELP
## vscode_keyrepeat_enable

For MacOS, set the key repeat of VSCode to be enabled

...shell
vscode_keyrepeat_enable
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
}

vscode_keyrepeat_disable() {
    local help=$(cat <<HELP
## vscode_keyrepeat_disable

For MacOS, disable the key repeat of VSCode

...shell
vscode_keyrepeat_disable
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool true
}
