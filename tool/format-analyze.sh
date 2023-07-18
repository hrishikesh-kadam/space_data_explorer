#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

set -x

dart format --output none --set-exit-if-changed .

dart run import_sorter:main --exit-if-changed

flutter analyze
