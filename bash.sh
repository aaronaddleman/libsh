# load any additional settings
[ -d $HOME/.bash.d ] && source $HOME/.bash.d/*.sh

# if exa exists, lets use it instead
if hash exa 2>/dev/null;then
	  alias lse="exa --color-scale --time-style=full-iso --git"
fi

if hash xclip 2>/dev/null;then
	  alias setclip="xclip -selection c"
	  alias getclip="xclip -selection c -o"
	  alias pbcopy="xclip -selection c"
	  alias pbpaste="xclip -selection c -o"
fi

# mask a string leaving out the last n chars
libsh_mask() {
    local n=3                    # number of chars to leave
    local a="${1:0:${#1}-n}"     # take all but the last n chars
    local b="${1:${#1}-n}"       # take the final n chars
    printf "%s%s\n" "${a//?/*}" "$b"   # substitute a with asterisks
}
