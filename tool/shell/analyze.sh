#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

./tool/shell/shellcheck.sh

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  ./tool/shell/scriptanalyzer.sh
fi
