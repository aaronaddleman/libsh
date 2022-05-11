figlet_install_fonts() {
    local help=$(cat <<HELP
## figlet_install_fonts

Install figlet fonts to the default of $HOME/src/figlet-fonts/ or
it accepts any dir you provide.

...shell
figlet_install_fonts
figlet_install_fonts your/destination
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0

    dest=${1-$HOME/src/figlet-fonts}
    [ ! -d $dest ] && git clone https://github.com/xero/figlet-fonts.git $dest
}

figlet_ban() {
    local help=$(cat <<HELP
## figlet_ban

Fun banner with figlet and lolcat. There are some settings that are assumed
or you can replace them with your own. Below are the description and default
values.


...shell
# where you have your figlet fonts installed
FIGLET_FONT_DIR=$HOME/src/figlet-fonts

# what font file to use
LOLBAN_FONT_FILE=3d.flf

# font name to use
LOLBAN_FONT_NAME=3d

figlet_ban "your message"
...

HELP
          )
    [[ "${1}" =~ "-help"$ ]] && libsh__help_doc "$help" && return 0
  # first param is the message encapsulated in quotes
  MSG=$1
  # if you want to override the FIGLET_FONT_DIR, set the var
  # or it will use its default value
  FIGLET_FONT_DIR=${FIGLET_FONT_DIR:-$HOME/src/figlet-fonts}
  # set your own font,
  # or use the default
  LOLBAN_FONT_FILE=${LOLBAN_FONT_FILE:-3d.flf}
  # set your own font name
  # or use the default
  LOLBAN_FONT_NAME=${LOLBAN_FONT_NAME:-3d}
  [ -f "$FIGLET_FONT_DIR/$LOLBAN_FONT_FILE" ] || libsh__exit_with_message "ERR" "Missing file ${FIGLET_FONT_DIR}/${LOLBAN_FONT_FILE}. Try figlet_install_fonts"
  command -v figlet > /dev/null 2>&1
  [ "$?" = 0 ] || __exit_with_message "ERR" "Figlet missing"
  command -v lolcat > /dev/null 2>&1
  [ "$?" = 0 ] || __exit_with_message "ERR" "Missing lolcat. Install with 'gem install lolcat'"
  figlet -f $LOLBAN_FONT_NAME -d $FIGLET_FONT_DIR "$MSG" | lolcat
}
