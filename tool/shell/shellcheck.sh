#!/usr/bin/env bash

set -e -o pipefail

echo "ShellCheck in process"

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  shellcheck="shellcheck.exe"
else
  shellcheck="shellcheck"
fi

find ./tool -name "*.sh" \
  -exec $shellcheck {} +

print_in_green "ShellCheck completed"
