#!/usr/bin/env bash

# This shell script is meant to be sourced.
# logs-env-posix.sh is a POSIX script.
# POSIX doesn't have `export -f` feature.

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
if shopt -qo pipefail; then PARENT_PIPEFAIL=true; else PARENT_PIPEFAIL=false; fi

set -e -o pipefail

export -f print_in_red
export -f print_in_yellow
export -f print_in_green
export -f print_in_cyan
export -f log_error
export -f log_warning
export -f log_info
export -f log_debug
export -f log_error_with_exit
export -f log_error_with_help

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
if [ $PARENT_PIPEFAIL = "true" ]; then set -o pipefail; else set +o pipefail; fi
