#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

# For Golden File Test
# Keep checking for any better solution for updating icons
# https://github.com/flutter/flutter/wiki/Updating-Material-Design-Fonts-&-Icons
cp "$FLUTTER_ROOT/bin/cache/artifacts/material_fonts/Roboto-Regular.ttf" \
  "assets/fonts/Roboto"
cp "$FLUTTER_ROOT/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf" \
  "assets/fonts/MaterialIcons"

flutter create . --org "dev.hrishikesh_kadam.flutter"

# if ! jq -e '. == {}' lib/l10n/unstranslated-messages.json &> /dev/null; then
#   log_error_with_exit "Unstranslated messages found" 1
# fi

dart run build_runner build --delete-conflicting-outputs
