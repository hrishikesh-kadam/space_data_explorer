#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

flutter create . --org "dev.hrishikesh_kadam.flutter"

if ! jq -e '. == {}' lib/l10n/unstranslated-messages.json &> /dev/null; then
  log_error_with_exit "Unstranslated messages found" 1
fi

dart run build_runner build --delete-conflicting-outputs
