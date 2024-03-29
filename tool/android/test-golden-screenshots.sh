#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

if (( $(git status -s pubspec.yaml | wc -l) > 0 )); then
  PUBSPEC_MODIFIED=true
  git stash push -m "pubspec.yaml at $(date +"%d/%m/%Y %r")" pubspec.yaml
  git stash apply 0
fi

AVD_NAMES=(
  "Pixel_7_API_34"
  # "Nexus_7_API_34"
  # "Nexus_10_API_34"
)
DEVICE_NAMES=(
  "pixel_7"
  # "Nexus 7 2013"
  # "Nexus 10"
)
SKIN_NAMES=(
  "pixel_7"
  # "nexus_7_2013"
  # "nexus_10"
)
IMAGE_NAME_SUFFIXES=(
  "_en-US"
  # "_en-US"
  # "_en-US"
)
GOLDEN_DIRECTORIES=(
  "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/phoneScreenshots"
  # "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/sevenInchScreenshots"
  # "android/fastlane/$FLAVOR_ENV/metadata/android/en-US/images/tenInchScreenshots"
)

for i in "${!AVD_NAMES[@]}"; do

  ./tool/android/start-emulator.sh \
    "${AVD_NAMES[i]}" "" "${DEVICE_NAMES[i]}" "${SKIN_NAMES[i]}"

  export GOLDEN_DIRECTORY="${GOLDEN_DIRECTORIES[i]}/"
  yq -i '.flutter.assets += [strenv(GOLDEN_DIRECTORY)]' pubspec.yaml

  flutter pub get

  # Flaky Test
  set +e +o pipefail
  flutter test \
    --flavor "$FLAVOR_ENV" \
    --dart-define="FLAVOR_ENV=$FLAVOR_ENV" \
    --dart-define="FLUTTER_TEST=true" \
    --dart-define="SCREENSHOT_TEST=true" \
    --dart-define="IMAGE_NAME_SUFFIX=${IMAGE_NAME_SUFFIXES[i]}" \
    --dart-define="GOLDEN_DIRECTORY=${GOLDEN_DIRECTORIES[i]}" \
    integration_test/golden_screenshots_test.dart
  set -e -o pipefail

  git restore pubspec.yaml
  if [[ $PUBSPEC_MODIFIED == true ]]; then
    git stash apply 0
  fi

  ./tool/android/kill-emulator.sh "${AVD_NAMES[i]}" || true

done
