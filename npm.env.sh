# npm env

# npm command found?
command -v npm > /dev/null
# if npm exists, add the global path to your paths
[ "${?}" = "0" ] && libsh__add_path "post" "$(npm get prefix)/bin" && libsh__debug "ENV  Append npm path"
