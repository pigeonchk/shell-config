#!/usr/bin/env bash

# TODO DOCUMENTATION

# @report <error type> [<error number> [<context>]] <message>...
#
# The @report function shall print to the error stream (stdout, by default)
# each message in its own line, prefixed by the the error type. The location of
# the caller (if available) is printed below the last line.
#
# If the optional argument [<error number>] is given, then a message describing
# that error is printed before each message, with an optional context and
# separated by the message with a colon (:).
#
# The resulting format is the following:
#   <error type>    [<error number description>[ '<context>']:] <message>
#           at <function name> from <script path>
#
# Example:
#   @report ET_SYST EACCES 'path/to/tool.conf' 'Could not read configuration'
#   *SYSTERR*    Permission denied 'path/to/tool.conf': Could not read...
#           at read_conf from some/shell/script.sh:51 [SS:MM:HH-YYYYDDMM]
#
# This function shall not fail. In case of unrecognized argument, a sane default
# will be chosen. ET_PROG for <error type>, while an invalid <error number> is
# ignored, with only the context being printed instead.
#
# Colors are automatically used if the error stream is a terminal [isatty(3)].
#
# The error stream can be overriden using environment variables:
#
#   SFTREPORT_STREAM    A filename or a [opened] file descriptor. This stream
#                       is exclusive to the calling process and its children.
#                       In case it was detected that the stream is already in
#                       use, then the value is ignored and the default stream
#                       is used.
#
#  SFTREPORT_STREAM_GL  The path to a file or a file descriptor which is to be
#                       added to the global list of streams.
@report() {
    local -A ERRT=([ET_SYST]="SYSTERR" [ET_USER]="USERERR" [ET_PROG]="PROGBUG"
                   [ET_CRIT]="SYSCRIT" [ET_EMRG]="SYSEMRG" [ET_ALRT]="SYSALRT"
                   [ET_INFO]="USRINFO" [ET_DBUG]="PRGDBUG")
    local errt="ET_PROG"

    [ "${ERRT[$1]}" ] && errt="$1"

    {
    # This is temporary, since I will be creating a standalone binary/daemon for
    # software reporting.
    printf "*%s* %s.\n" "${ERRT[$errt]}" "$*"
    printf "        at %s from %s:%d\n" "${FUNCNAME[1]}" "${BASH_SOURCE[1]}" \
                                        "${BASH_LINENO[1]}"
    } >"${SFTREPORT_STREAM:-&2}"
}

[ "$SHOULD_EXPORT" ] && export -f @report
