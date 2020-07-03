case $SHELL in
  *zsh)
    setopt correct
    ;;
  *bash)
    shopt -s cdspell
    ;;
esac
