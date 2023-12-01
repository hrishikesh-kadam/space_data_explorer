#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

ADB_DEVICES_OP_LINE_IGNORE=2
ADB_DEVICES_OP=$(adb devices | wc -l)
DEVICES_COUNT=$((ADB_DEVICES_OP - ADB_DEVICES_OP_LINE_IGNORE))

if ((DEVICES_COUNT <= 0)); then
  ./tool/android/start-emulator.sh
fi

flutter run \
  --flavor "$FLAVOR_ENV" \
  --dart-define="FLAVOR_ENV=$FLAVOR_ENV"

./tool/android/kill-emulator.sh || true
