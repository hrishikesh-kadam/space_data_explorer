#!/usr/bin/env bash

set -e -o pipefail

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  shellcheck="shellcheck.exe"
else
  shellcheck="shellcheck"
fi

find ./tool -name "*.sh" \
  -exec $shellcheck {} +
