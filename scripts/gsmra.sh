git submodule foreach "$(echo $1) || exit 0"; eval "$1"