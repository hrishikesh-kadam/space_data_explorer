#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

chromedriver --port=4444 &
TARGET_PATHS=(
  "integration_test/app_bar_back_button_test.dart"
)
if [[ $GITHUB_ACTIONS == "true" ]] ; then
  DEVICE="web-server"
else
  DEVICE="chrome"
fi
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter drive \
    --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
    --dart-define="FLUTTER_TEST=true" \
    --driver test_driver/integration_test.dart \
    --target "$TARGET_PATH" \
    -d $DEVICE
done
