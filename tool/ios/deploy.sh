#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

source ./tool/constants.sh

if [[ $FLAVOR_ENV == "prod" ]]; then
  ./tool/ios/upload-all.sh "$FLAVOR_ENV"
else
  ./tool/ios/upload-metadata-screenshots.sh "$FLAVOR_ENV"
  ./tool/ios/upload-ipa.sh "$FLAVOR_ENV"
fi

FIREBASE_DART_FILE="lib/config/firebase/options/$FLAVOR_ENV.dart"
# shellcheck disable=SC2086
FIREBASE_APP_ID=$( \
  jq -r \
    '.flutter.platforms.dart."'$FIREBASE_DART_FILE'".configurations.ios' \
    firebase.json
)

# EXECUTABLE_NAME="$APP_NAME_KEBAB_CASE-$FLAVOR_ENV-release"
# WRAPPER_NAME="$APP_NAME_KEBAB_CASE-$FLAVOR_ENV-release.app"
# DWARF_DSYM_FOLDER_PATH="./build/ios/archive/$EXECUTABLE_NAME.xcarchive/dSYMs"
# DWARF_DSYM_FILE_NAME="$WRAPPER_NAME.dSYM"

# shellcheck disable=SC1091
source ./build/ios/build-phases-variables.env

./ios/Pods/FirebaseCrashlytics/upload-symbols \
  --app-id "$FIREBASE_APP_ID" \
  --platform ios \
  "$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME"

# flutterfire upload-crashlytics-symbols \
#   --upload-symbols-script-path "$PODS_ROOT/FirebaseCrashlytics/upload-symbols" \
#   --debug-symbols-path "$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME" \
#   --info-plist-path "$SRCROOT/$BUILT_PRODUCTS_DIR/$INFOPLIST_PATH" \
#   --platform ios \
#   --apple-project-path "$SRCROOT" \
#   --build-configuration "$CONFIGURATION"

# shellcheck disable=SC1091
source ./secrets/sentry/source.sh
sentry-cli debug-files upload \
  --include-sources \
  "$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME"
