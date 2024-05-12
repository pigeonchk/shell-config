#!/bin/bash

# Returns the path of a command. Bypasses shell functions and aliases.
@bin() { builtin type -P "$1"; }
# These functions whether a command is a function, alias, or a builtin.
#
# Cannot return the path of the script that defined it since bash does not keep
# a record of it, afaik.
@fun() { [ "$(builtin type -t "$1")" = function ]; }
@ali() { [ "$(builtin type -t "$1")" = alias ]; }
@bui() { [ "$(builtin type -t "$1")" = builtin ]; }

@chkbin() {
    local origin="${BASH_SOURCE[1]}"
    [ "$origin" ] || origin="<interactive>"
    if [ ! "$(@bin "$1")" ]; then
        command printf "*MISSING* from %s * command not found: %s\n" \
                       "$origin" "$1"
    fi
}

@chkvarpath() {
    local origin="${BASH_SOURCE[1]}"
    [ "$origin" ] || origin="<interactive>"
    if [ ! -r "${!1}" ]; then
        command printf "*MISSING* from %s * path not found: %s (%s)\n" \
                       "$origin" "$1" "%${!1}"
    fi
}

export -f @bin @fun @ali @bui @chkbin @chkvarpath
