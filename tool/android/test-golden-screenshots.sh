#!/usr/bin/env bash

set -e -o pipefail

if (( $(git status -s pubspec.yaml | wc -l) > 0 )); then
  PUBSPEC_MODIFIED=true
fi
git stash push -m "pubspec.yaml at $(date +"%d/%m/%Y %r")" pubspec.yaml

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

AVD_NAMES=(
  "Pixel_6_API_33"
  # "Nexus_7_API_33"
  # "Nexus_10_API_33"
)
DEVICE_NAMES=(
  "pixel_6"
  # "Nexus 7 2013"
  # "Nexus 10"
)
GOLDEN_DIRECTORIES=(
  "android/app/src/$FLAVOR_ENV/play/listings/en-US/graphics/phone-screenshots"
  # "android/app/src/$FLAVOR_ENV/play/listings/en-US/graphics/tablet-screenshots"
  # "android/app/src/$FLAVOR_ENV/play/listings/en-US/graphics/large-tablet-screenshots"
)

for i in {0..0}; do

  source ./tool/android/start-emulator.sh \
    "${AVD_NAMES[i]}" \
    "" \
    "${DEVICE_NAMES[i]}"

  export GOLDEN_DIRECTORY="${GOLDEN_DIRECTORIES[i]}/"
  yq -i '.flutter.assets += [strenv(GOLDEN_DIRECTORY)]' pubspec.yaml

  flutter pub get

  # Flaky Test
  set +e +o pipefail
  flutter test \
    --flavor "$FLAVOR_ENV" \
    --dart-define="FLUTTER_TEST=true" \
    --dart-define="GOLDEN_DIRECTORY=${GOLDEN_DIRECTORIES[i]}" \
    integration_test/golden_screenshots_test.dart
  set -e -o pipefail

  git restore pubspec.yaml

  ./tool/android/kill-emulator.sh "${AVD_NAMES[i]}"

done

if [[ $PUBSPEC_MODIFIED == true ]]; then
  git stash apply 0
fi
