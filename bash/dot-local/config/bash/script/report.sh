#!/bin/bash
# vim:foldmethod=marker:foldlevel=0

# shellcheck disable=2155,1091

# TODO documentation.

# {{{ USER_REPORT_LEVELS definition

if ! declare -p USER_REPORT_LEVELS &>/dev/null; then
    # PIDS :) Pigeonchk Individual Developer Standard :)
    declare -Arx PIDS_ERRORS=(
        ['program_bug']=1
        ['system_error']=1
        ['user_error']=1
    )

    # PIDS :) Pigeonchk Individual Developer Standard :)
    declare -Arx PIDS_ERROR_NAMES=(
        ['program_bug']="*BUG*"
        ['system_error']="*SYS_ERROR*"
        ['user_error']="*USR_ERROR*"
    )

    [ ! -v SGR0 ] &&
        declare -rx SGR0="$(tput sgr0)"

    bold="$(tput bold)"
    black_bold="$(tput setaf 0)$bold"
    declare -Arx PIDS_ERROR_BG=(
        ['program_bug']="$black_bold$(tput setab 7)"
        ['system_error']="$black_bold$(tput setab 9)"
        ['user_error']="$black_bold$(tput setab 11)"
    )

    declare -Arx PIDS_ERROR_FG=(
        ['program_bug']="$bold$(tput setaf 7)"
        ['system_error']="$bold$(tput setaf 9)"
        ['user_error']="$bold$(tput setaf 11)"
    )

    declare -Arx PIDS_ELEMENT_FG=(
        ['link']="$bold$(tput setaf 12)"
    )
    unset black_bold bold

    declare -Arx PIDS_ERROR_COLOR_NAMES=(
        ['program_bug']="${PIDS_ERROR_BG['program_bug']}*BUG*$SGR0"
        ['system_error']="${PIDS_ERROR_BG['system_error']}*SYS_ERROR*$SGR0"
        ['user_error']="${PIDS_ERROR_BG['user_error']}*USR_ERROR*$SGR0"
    )

    declare -Arx USER_REPORT_LEVELS=(
        ['bug']='program_bug'
        ['system']='system_error'
        ['user']='user_error'
    )
fi

# }}}

# {{{ Internal functions

@_report() {
    local sep="⁂"
    local lvl="$1"
    local func="$2"

    shift 2

    [ "$USER_USE_ASCII" ] && sep="*"

    if [ ! "${PIDS_ERRORS[$lvl]}" ]; then
        set "invalid report level: $lvl"
        func='@_report'
        lvl='user_error'
    fi

    local lvlname="${PIDS_ERROR_NAMES[$lvl]}"
    if [ -t 2 ]; then
        lvlname="${PIDS_ERROR_COLOR_NAMES[$lvl]}"
        func="${PIDS_ERROR_FG[$lvl]}$func$SGR0"
    fi

    for line; do
        command printf "%s from %s %s %s.\n" "$lvlname" "$func" "$sep" "$line"
    done
    [ "${BASH_SOURCE[0]}" ] && command kill -s TERM $$
} >&2

@_invalid_report_level() {
    @_report 'user_error' "${FUNCNAMES[1]}" "invalid report level: $1"
}

# }}}

@report_colorcode() {
    local lvl="$1"
    local str="$2"

    [ ! "${PIDS_ERRORS[$lvl]}" ] && @_invalid_report_level "$lvl"

    local str_coded="${PIDS_ERROR_FG[$lvl]}$str$SGR0"
    command printf "%s" "$str_coded"
}

@report() {

    local origin="${FUNCNAME[1]}"
    local lvl="$1"

    [ "${USER_REPORT_LEVELS[$lvl]}" ] && lvl="${USER_REPORT_LEVELS[$lvl]}"

    [ ! "${PIDS_ERRORS[$lvl]}" ] && @_invalid_report_level "$lvl"

    [ "$origin" ] ||
        { origin="${BASH_SOURCE[1]}"; origin="${func:-<interactive>}"; }

    shift 1

    local -a lines
    IFS=$'\n' read -a lines -r -d '' <<<"$@"

    if [ "$lvl" = program_bug ]; then
        local link="${GIT_REPO:-$USER_SHELL_CONFIG_GIT}"
        [ -t 2 ] && link="${PIDS_ELEMENT_FG['link']}$link$SGR0"
        lines+=("report this issue at: $link")
    fi

    @_report "$lvl" "$origin" "${lines[@]}"
}

export -f @_report @_invalid_report_level @report_colorcode @report
