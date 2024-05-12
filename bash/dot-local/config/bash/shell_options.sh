#!/bin/bash
# vim:foldmethod=marker:foldlevel=0

# {{{ shopt: spelling correction

# cdspell  correct minor spelling errors when cd'ing.
# dirspell correct minor spelling errors when expanding directories.
shopt -s cdspell dirspell

# }}} shopt: spelling correction

# {{{ shopt: history

# histappend    Append to the history file, don't overwrite it.
# cmdhist       multi-line command is saved in the same line
# histverify    send history substitution to the readline buffer.
shopt -s histappend cmdhist histverify

# }}} shopt: history

# {{{ shopt: expansion

# assoc_expand_once evaluate associative arrays only once.
# globstar          expand all files and (sub)directories.
shopt -s assoc_expand_once globstar

# }}} shopt: expansion

# {{{ shopt: glob

# extglob           enables extended glob features.
# globasciiranges   use the C locale with pattern ranges.
shopt -s extglob globasciiranges

# }}} shopt: glob

# {{{ shopt: interactive execution

# checkhash         checks the hash tables before executing a command.
# checkjobs         defer exiting if there's any running job.
shopt -s checkhash checkjobs

# }}} shopt: interactive execution

# {{{ shopt: cd'ing

# autocd        used a directory name directly without cd.
# cdable_vars   use variable names with cd.
shopt -s autocd cdable_vars

# }}} shopt: cd'ing

# {{{ shopt: completion

# progcomp_alias    completion on aliases.
shopt -s progcomp_alias

# }}} shopt: completion

