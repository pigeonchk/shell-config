#!/bin/bash

# shellcheck disable=2155,1091,2016

declare -ax PPT_SHAPE=(
    '╭─┤\1├─┤\2├─\$┤\3├─\$┤\4├─┤\5├─┤\a├╴\ '
    '│ \$                           │\#a│\ \ \ '
    '│ \$                           │\#a│\ \ \ '
    '╰─┤├─╴ \ '
)

declare -Ax PPT_CONSTS=(
    ['1']="$PPT_USER_SMLUPPER"
    ['2']="$PPT_HOSTNAME_SMLUPPER"
    ['3']="$PPT_DIST_SMLUPPER$PPT_DISTVER_SUP"
    ['4']="$PPT_CPUMODEL_SMLUPPER"
    ['5']="$PPT_SHELL_SMLUPPER$PPT_SHELLVER_SUB"
)

@ppt_expand_time() {
    local -a weekdays=(Su Mo Tu We Th Fr Sa)
    local weekday='\D{%u}'
    local t='\t'
    local day='\D{%e}'
    local -a weekdaysrow
    local -a daysrow

    weekday="${weekday@P}"
    t="${t@P}"
    day="${day@P}"

    weekdaysrow+=("${weekdays[$((weekday-1))]}")
    weekdaysrow+=("${weekdays[$weekday]}")
    weekdaysrow+=("${weekdays[$((weekday+1))]}")

    daysrow+=("$((day - (day > 0 && 1)))")
    daysrow+=("$((day + (day == 0 && 1)))")
    daysrow+=("$((day + 1 + (day == 0 && 1)))")

    local row="${weekdaysrow[*]}"
    local -i align="$((${#row} - ${#t}))"
    {
    command printf '%*s\n' "$((align+${#t} - (align%2)))" "$t"
    command printf '%s\n' "${weekdaysrow[*]}"
    command printf '%0.2d ' "${daysrow[@]}" | xargs
    } | @txt_tr 'upper|lower|digit' 'smlupper|smlupper|segdigit'
}

@ppt_get_vars_length() {
    local -i len=0
    while IFS=$'\n' read -r line; do
        (( ${#line} > len)) && len=${#line}
    done <<<"$(${PPT_VARS[$1]})"

    command printf "%d" "$len"
}

declare -Ax PPT_VARS=(
    ['a']="@ppt_expand_time"
)

declare -Ax PPT_VARS_LENGTH=(
    ['a']="$(@ppt_get_vars_length 'a')"
)

declare -ix PPT_ISCACHED=0
declare -x PPT_SHAPE_CACHED

@ppt_expand_const() {
    local expanded="$1"
    while IFS=$'\n' read -r i; do
        i="${i#\\}"
        local const="${PPT_CONSTS[$i]}"
        expanded="$(command sed -E "s^\\\\$i^$const^" <<<"$expanded")"
    done < <(command grep -Eo -e '\\[0-9]+' <<<"$expanded")

    printf "%s" "$expanded"
}

@ppt_expand_vars_into_spaces() {
    local expanded="$1"
    local pfx="$2"
    while IFS=$'\n' read -r v; do
        v="${v#\\$pfx}"
        (( PPT_VARS_LENGTH[$v] > 0 )) ||
            PPT_VARS_LENGTH[$v]=$(@ppt_get_vars_length "$v")

        local -i len="${PPT_VARS_LENGTH[$v]}"

        local spaces="$(@txt_rep $len " ")"
        expanded="$(command sed -E "s^\\\\$pfx$v^$spaces^" <<<"$expanded")"
    done < <(command grep -Eo -e "\\\\$pfx[a-z]+" <<<"$expanded")

    printf "%s" "$expanded"
}

@ppt_expand_repeat() {
    local c="$1"
    (( ${#c} != 1)) && @report 'user' 'rep_char must have length of one'

    local -a parts
    local -i total=0
    while IFS=$'\n' read -t 0.01 -r part; do
        parts+=("$part")
        total=$((total + ${#part}))
    done

    ((total == 0)) && return

    local -i torepeat=$((COLUMNS - total))
    local -i filler_length=$((torepeat / (${#parts[@]}-1)))

    local filler="$(@txt_rep "$filler_length" "$c")"

    local filled
    for ((i = 0; i < ${#parts[@]}; i++)); do
        local extra=
        local f="$filler"

        (( ${#parts[@]} > 2 && i == (${#parts[@]}-1) && spaces > 0 &&
            torepeat % 2 != 0 )) && extra=$c
        (( i == 0 )) && f=""
        filled="$filled$f$extra${parts[$i]}"
    done

    eval "$2='$filled'"
}

@ppt_cache_shape() {
    local -a expanded_lines

    for line in "${PPT_SHAPE[@]}"; do
        # replace ' \$' with a '​' (U+200b zero width space)
        # this way we can trim all blanks without worrying about
        # removing this one
        expanded="$(command sed -E 's/ \\\$/​/g' <<<"$line")"
        # For the same reason, change escaped spaces with a
        # (U+200c zero width non-joiner)
        expanded="$(command sed -E 's/\\[[:blank:]]/‌/g' <<<"$expanded")"
        expanded="$(LC_ALL=C command sed -E \
            's/[[:blank:]]*//g' <<<"$expanded")"

        expanded="$(@ppt_expand_const "$expanded")"
        expanded="$(@ppt_expand_vars_into_spaces "$expanded")"
        expanded="$(@ppt_expand_vars_into_spaces "$expanded" '#')"

        local -i spaces="$({ command grep -o '‌' |
                    wc -l; } <<<"$expanded")"

        @ppt_expand_repeat " " expanded $spaces < <(command sed -E -n \
                        -e 's/​/\n/gp' <<<"$expanded")

        while IFS=$'\n' read -r c; do
            @ppt_expand_repeat "$c" expanded $spaces < <(command sed -E \
                                's/.\\\$/\n/g' <<<"$expanded")
        done < <(command grep -P -o '.(?=\\\$)' <<<"$expanded" | uniq)

        expanded="$(command sed -E "s/‌/ /g" <<<"$expanded")"
        expanded_lines+=("$expanded")
    done

    PPT_SHAPE_CACHED="$(printf "%s\n" "${expanded_lines[@]}")"
    PPT_ISCACHED=1
}

@ppt_draw() {
    (( PPT_ISCACHED == 0 )) && @ppt_cache_shape

    PS1="$PPT_SHAPE_CACHED"
}

export -f @ppt_expand_const @ppt_expand_repeat \
          @ppt_expand_vars_into_spaces @ppt_cache_shape @ppt_draw
