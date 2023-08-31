#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

echo "ShellCheck in process"

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  shellcheck="shellcheck.exe"
else
  shellcheck="shellcheck"
fi

find ./tool ./secrets -name "*.sh" \
  -exec $shellcheck {} +

print_in_green "ShellCheck completed"
