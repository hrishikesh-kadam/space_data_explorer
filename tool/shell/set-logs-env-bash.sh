#!/usr/bin/env bash

# This shell script is meant to be sourced.
# set-logs-env.sh is a POSIX script.
# POSIX doesn't have `export -f` feature.

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
if shopt -qo pipefail; then PARENT_PIPEFAIL=true; else PARENT_PIPEFAIL=false; fi

set -e -o pipefail

export -f print_in_red
export -f print_in_yellow
export -f print_in_green
export -f print_in_cyan
export -f error_log
export -f warning_log
export -f info_log
export -f debug_log
export -f error_log_with_exit
export -f error_log_with_help

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
if [ $PARENT_PIPEFAIL = "true" ]; then set -o pipefail; else set +o pipefail; fi
