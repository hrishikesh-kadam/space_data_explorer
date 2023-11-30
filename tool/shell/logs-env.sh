#!/usr/bin/env bash

source ./tool/shell/logs-env-posix.sh
source ./tool/shell/logs-env-bash.sh

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
if shopt -qo pipefail; then PARENT_PIPEFAIL=true; else PARENT_PIPEFAIL=false; fi

set -e -o pipefail

PRINT_DEBUG_LOG=1
PRINT_INFO_LOG=1
PRINT_WARNING_LOG=1

export LOGS_ENV_SOURCED="true"

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
if [ $PARENT_PIPEFAIL = "true" ]; then set -o pipefail; else set +o pipefail; fi
