#!/usr/bin/env bash

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

