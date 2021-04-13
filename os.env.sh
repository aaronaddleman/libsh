#
# Uname detection
#
LIBSH_UNAME=$(uname)
[[ "$LIBSH_UNAME" == "Linux" ]] && export set LIBSH_OS="Linux"
[[ "$LIBSH_UNAME" == "Darwin" ]] && export set LIBSH_OS="Darwin"
[[ "$LIBSH_UNAME" == CYGWIN* || "$LIBSH_UNAME" == MINGW* ]] && export set LIBSH_OS="Windows"