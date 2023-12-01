#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

./tool/android/start-emulator.sh

# mapfile -t TARGET_PATHS < <(find integration_test -type f -name "*_test.dart")
TARGET_PATHS=(
  "integration_test/app_bar_back_button_test.dart"
)
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
  flutter test \
    --flavor "$FLAVOR_ENV" \
    --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
    --dart-define="FLUTTER_TEST=true" \
    "$TARGET_PATH"
done

./tool/android/kill-emulator.sh || true
