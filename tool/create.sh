#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

flutter create . --org "dev.hrishikesh_kadam.flutter"
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
rm ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png

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
