vscode_keyrepeat_enable()
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
}

vscode_keyrepeat_disable() {
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool true
}