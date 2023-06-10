#!/usr/bin/env bash

set -e -o pipefail

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  Shellcheck="shellcheck.exe"
else
  Shellcheck="shellcheck"
fi

find ./tool -name "*.sh" \
  -exec $Shellcheck {} +
