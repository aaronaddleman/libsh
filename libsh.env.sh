#
# Uname detection
#
UNAME=$(uname)
if [[ "$UNAME" == "Linux" ]]; then
    export set LIBSH_OS="Linux"
elif [[ "$UNAME" == "Darwin" ]] ; then
	export set LIBSH_OS="Darwin"
elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
	export set LIBSH_OS="Windows"
fi