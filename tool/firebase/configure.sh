#!/usr/bin/env bash

set -e -o pipefail

source ./tool/constants.sh

FIREBASE_PROJECTS=(
  "$APP_NAME_KEBAB_CASE-dev"
  "$APP_NAME_KEBAB_CASE-stag"
  "$APP_NAME_KEBAB_CASE"
)
OPTIONS_DART_FILES=(
  "lib/firebase/options/dev.dart"
  "lib/firebase/options/stag.dart"
  "lib/firebase/options/prod.dart"
)
PLATFORMS=(
  "android,web"
  "android,web"
  "android,web"
)
ANDROID_APP_IDS=(
  "$ANDROID_APP_ID.dev.release"
  "$ANDROID_APP_ID.stag.release"
  "$ANDROID_APP_ID"
)
ANDROID_OUT_FILES=(
  "/android/app/src/dev/google-services.json"
  "/android/app/src/stag/google-services.json"
  "/android/app/src/prod/google-services.json"
)

for ((i=0; i < ${#FIREBASE_PROJECTS[@]}; i++)); do
  dart run flutterfire_cli:flutterfire configure \
    --project="${FIREBASE_PROJECTS[i]}" \
    --out="${OPTIONS_DART_FILES[i]}" \
    --yes \
    --platforms="${PLATFORMS[i]}" \
    --android-package-name="${ANDROID_APP_IDS[i]}" \
    --android-out="${ANDROID_OUT_FILES[i]}"
done
