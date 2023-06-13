#!/usr/bin/env bash

set -e -o pipefail

./tool/shell/shellcheck.sh

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  ./tool/shell/scriptanalyzer.sh
fi
