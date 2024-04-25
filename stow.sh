#!/bin/bash

# http://www.linuxquestions.org/questions/user/catkin-444761/
# shellcheck disable=2120
function get_source() {
    local FILE="${1:-$0}"
    FILE="${FILE%/}"

    local FILE_BASENAME="${FILE##*/}"
    local DIR="${FILE%"$FILE_BASENAME"}"

    # do not cd if DIR is the working directory
    if [[ ! -e "./$FILE_BASENAME" ]]; then
        cd "$DIR" || return 1
    fi

    printf "%s/%s" "$(pwd -P)" "$FILE_BASENAME"

    cd "-" &>/dev/null || return 1

    return 0
}

STOW="${STOW:-stow}"
BASEDIR="$(get_source | xargs dirname --)"

if ! command -v "$STOW" &>/dev/null; then
    printf "stow.sh: command 'stow' not installed.\n"
    exit 1
fi

if (($# != 1))  then
    printf "usage: ./stow.sh package\n"
    exit 1
fi

if test ! -d "$1"; then
    printf "invalid package name: %s\n" "$1"
    exit 1
fi

printf "Stow will perform the following operations:\n\n"
if ! $STOW -n -v -R --dotfiles -t "$HOME" "$1"; then
    printf "%s\n%s\n%s\n" \
           "bug: stow prior to version 2.4.0 has a bug where directories starting with dot-*" \
           "     would cause stow to fail when using the --dotfiles along with --target." \
           "     The issue (#33) was merged by commit #56727 and released at version 2.4.0."
    exit 1
fi

declare -l reply
read -r -p "Should continue? [y/n] " reply

test "$reply" = y && $STOW -v -R --dotfiles -t "$HOME" "$1"
