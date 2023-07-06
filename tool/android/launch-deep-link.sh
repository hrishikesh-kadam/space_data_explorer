#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

APP_URL=$(./tool/constants/app-url.sh)

pushd android &> /dev/null
APPLICATION_ID=$(./gradlew \
  -q :app:getApplicationId \
  -PvariantName="${FLAVOR_ENV}Debug")
popd &> /dev/null

adb shell am start -a android.intent.action.VIEW \
  -c android.intent.category.BROWSABLE \
  -d "$APP_URL/nasa-source/cad" \
  "$APPLICATION_ID"
