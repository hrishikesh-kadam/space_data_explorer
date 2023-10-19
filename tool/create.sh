#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

flutter create . --org "dev.hrishikesh_kadam.flutter"

# For Golden File Test
# Keep checking for any better solution for updating icons
# https://github.com/flutter/flutter/wiki/Updating-Material-Design-Fonts-&-Icons
# flutter create downloads assets of material_fonts if the directory is absent
cp "$FLUTTER_ROOT/bin/cache/artifacts/material_fonts/Roboto-Regular.ttf" \
  "assets/fonts/Roboto"
cp "$FLUTTER_ROOT/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf" \
  "assets/fonts/MaterialIcons"

# if ! jq -e '. == {}' lib/l10n/unstranslated-messages.json &> /dev/null; then
#   log_error_with_exit "Unstranslated messages found" 1
# fi

dart run build_runner build --delete-conflicting-outputs
