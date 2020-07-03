lolban() {
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
	[ -f "$FIGLET_FONT_DIR/$LOLBAN_FONT_FILE" ] || libsh__exit_with_message "ERR" "Missing file 3d.flf"
	command -v figlet > /dev/null 2>&1
	[ "$?" = 0 ] || __exit_with_message "ERR" "Figlet missing"
	command -v lolcat > /dev/null 2>&1
	[ "$?" = 0 ] || __exit_with_message "ERR" "Missing lolcat"
	figlet -f $LOLBAN_FONT_NAME -d $FIGLET_FONT_DIR "$MSG" | lolcat
}
