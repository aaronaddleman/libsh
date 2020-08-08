case $SHELL in
  *zsh)
      command -v setopt > /dev/null
      [ $? -eq 0 ] && setopt correct
    ;;
  *bash)
    shopt -s cdspell
    ;;
esac
