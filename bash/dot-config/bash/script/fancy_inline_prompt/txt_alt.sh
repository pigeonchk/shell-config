#!/bin/bash
# vim:foldmethod=marker:foldlevel=0

# shellcheck disable=2155,1091

. "comp.sh"
. "txt.sh"

@ppt_expand() {
    for arg; do
        command printf "%s\n" "${arg@P}"
    done

    while IFS=$'\n' read -t 0.01 -r line; do
        command printf "%s\n" "${line@P}"
    done
}

HOSTNAME_IP="$(command ip -4 -o addr |
               command grep -v -E '\blo\b' | @txt_inet)"

CPUMODEL="$(command lscpu | command grep -i 'model name' |\
                    command cut -d : -f 2 | xargs)"
CPUMODEL="${CPUMODEL% with*}"


# {{{ small uppercase letters

export PPT_OS_SMLUPPER       PPT_KERNEL_SMLUPPER PPT_DIST_SMLUPPER \
       PPT_HOSTNAME_SMLUPPER PPT_SHELL_SMLUPPER  PPT_USER_SMLUPPER \
       PPT_CPUMODEL_SMLUPPER

{ read -d '' -r PPT_OS_SMLUPPER    PPT_KERNEL_SMLUPPER   \
                PPT_DIST_SMLUPPER  PPT_HOSTNAME_SMLUPPER \
                PPT_SHELL_SMLUPPER PPT_USER_SMLUPPER \
                PPT_CPUMODEL_SMLUPPER < \
                <(@txt_upper |
                   @txt_tr "upper|digit" "smlupper|segdigit"); } <<EOF
$COMP_OS
$COMP_KERNEL
$COMP_LINUXDIST
$(@ppt_expand '\h' '\s' '\u')
$CPUMODEL
EOF

# }}} small uppercase letters

# {{{ segmented digits

export PPT_KERNELVER_SEGDIGIT PPT_ARCH_SEGDIGIT \
       PPT_DISTVER_SEGDIGIT   PPT_INET_SEGDIGIT \
       PPT_SHELLVER_SEGDIGIT

{ read -d '' -r PPT_KERNELVER_SEGDIGIT PPT_ARCH_SEGDIGIT \
                PPT_DISTVER_SEGDIGIT   PPT_INET_SEGDIGIT \
                PPT_SHELLVER_SEGDIGIT < \
                <(@txt_upper |
                   @txt_tr "upper|digit" "smlupper|segdigit"); } <<EOF
$COMP_KERNEL_VERSION
$COMP_ARCH
$COMP_LINUXDIST_VERSION
$HOSTNAME_IP
$(@ppt_expand '\V')
EOF

# }}} segmented digits

# {{{ superscripts

export PPT_KERNELVER_SUP PPT_DISTVER_SUP \
       PPT_INET_SUP PPT_SHELLVER_SUP

{ read -d '' -r PPT_KERNELVER_SUP  PPT_DISTVER_SUP\
                PPT_INET_SUP       PPT_SHELLVER_SUP < \
                <(@txt_tr "digit|separ" "supdigit|supsepar"); } <<EOF
$COMP_KERNEL_VERSION
$COMP_LINUXDIST_VERSION
$HOSTNAME_IP
$(@ppt_expand '\V')
EOF

# }}}

# {{{ subscripts

export PPT_KERNELVER_SUB PPT_DISTVER_SUB \
       PPT_INET_SUB PPT_SHELLVER_SUB

{ read -d '' -r PPT_KERNELVER_SUB  PPT_DISTVER_SUB \
                PPT_INET_SUB       PPT_SHELLVER_SUB < \
                <(@txt_tr "digit|separ" "subdigit|subsepar"); } <<EOF
$COMP_KERNEL_VERSION
$COMP_LINUXDIST_VERSION
$HOSTNAME_IP
$(@ppt_expand '\V')
EOF

# }}} subscripts

unset HOSTNAME_IP CPUMODEL

export -f @ppt_expand
