#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

TARGET_PATHS=(
  "integration_test/app_bar_back_button_test.dart"
)
REQUIRED_TIMES=(
  40
)
if [[ $GITHUB_ACTIONS == "true" ]] ; then
  DEVICE="web-server"
else
  DEVICE="chrome"
fi
for i in "${!TARGET_PATHS[@]}"; do
  (
    TARGET_PATH="${TARGET_PATHS[$i]}"
    REQUIRED_TIME="${REQUIRED_TIMES[$i]}"
    flutter run "${TARGET_PATH}" \
      --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
      --vmservice-out-file=coverage/vm-service-url.txt \
      -d $DEVICE &
    sleep "$REQUIRED_TIME"
    # TODO(hrishikesh-kadam): Source report kind Coverage not supported
    dart pub global run coverage:collect_coverage \
      --uri="$(cat coverage/vm-service-url.txt)" \
      --out "coverage/coverage_${TARGET_PATH}.json"
    rm coverage/vm-service-url.txt
    dart pub global run coverage:format_coverage \
      --lcov \
      --in "coverage/coverage_${TARGET_PATH}.json" \
      --out "coverage/lcov_${TARGET_PATH}.info"
    rm "coverage/coverage_${TARGET_PATH}.json"
    if [[ -s coverage/lcov.info ]]; then
      cp coverage/lcov.info coverage/lcov.base.info
      lcov --add-tracefile coverage/lcov.base.info \
        --add-tracefile "coverage/lcov_${TARGET_PATH}.info" \
        --output-file coverage/lcov.info
      rm coverage/lcov.base.info
    else
      cp "coverage/lcov_${TARGET_PATH}.info" coverage/lcov.info
    fi
    rm "coverage/lcov_${TARGET_PATH}.info"
  )
done
