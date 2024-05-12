#!/bin/bash

# shellcheck disable=1091

declare -p COMP &>/dev/null && return

export COMP_LINUXDIST="Unknown"
export COMP_LINUXDIST_VERSION="?"
if test -f /etc/os-release; then
    read -r COMP_LINUXDIST COMP_LINUXDIST_VERSION < \
        <(. /etc/os-release; command printf "%s %s" \
                    "${ID@u}" "$VERSION_ID")
fi

declare -Arx COMP=(
    ['os']="$OSTYPE"
    ['kernel']="$(command uname -s)"
    ['kernelver']="$(command uname -r |
            command sed -E 's/([0-9]+\.[0-9]+.[0-9]+-[0-9]+).*/\1/')"
    ['arch']="$(command uname -m)"
    ['dist']="$COMP_LINUXDIST"
    ['distver']="$COMP_LINUXDIST_VERSION"
)

declare -rx COMP_OS="${COMP['os']}"
declare -rx COMP_KERNEL="${COMP['kernel']}"
declare -rx COMP_KERNEL_VERSION="${COMP['kernelver']}"
declare -rx COMP_ARCH="${COMP['arch']}"
