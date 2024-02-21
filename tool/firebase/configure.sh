#!/usr/bin/env bash

set -e -o pipefail

source ./tool/constants.sh

FIREBASE_ACCOUNT="hrkadam.92@gmail.com"
if ! firebase login:list | grep "Logged in as $FIREBASE_ACCOUNT"; then
  firebase login:use $FIREBASE_ACCOUNT
fi

FIREBASE_PROJECTS=(
  "$APP_NAME_KEBAB_CASE-dev"
  "$APP_NAME_KEBAB_CASE-stag"
  "$APP_NAME_KEBAB_CASE"
)
OPTIONS_DART_FILES=(
  "lib/config/firebase/options/dev.dart"
  "lib/config/firebase/options/stag.dart"
  "lib/config/firebase/options/prod.dart"
)
PLATFORMS=(
  "android,ios,web"
  "android,ios,web"
  "android,ios,web"
)
ANDROID_APP_IDS=(
  "$ANDROID_APP_ID_BASE.dev"
  "$ANDROID_APP_ID_BASE.stag"
  "$ANDROID_APP_ID_BASE"
)
ANDROID_OUT_FILES=(
  "/android/app/src/dev/google-services.json"
  "/android/app/src/stag/google-services.json"
  "/android/app/src/prod/google-services.json"
)
APPLE_BUNDLE_IDS=(
  "$APPLE_BUNDLE_ID_BASE.dev"
  "$APPLE_BUNDLE_ID_BASE.stag"
  "$APPLE_BUNDLE_ID_BASE"
)
IOS_BUILD_CONFIGS=(
  "Release-dev"
  "Release-stag"
  "Release-prod"
)
IOS_OUT_FILES=(
  "/ios/config/dev/GoogleService-Info.plist"
  "/ios/config/stag/GoogleService-Info.plist"
  "/ios/config/prod/GoogleService-Info.plist"
)

for ((i=0; i < ${#FIREBASE_PROJECTS[@]}; i++)); do
  dart pub global run flutterfire_cli:flutterfire configure \
    --project="${FIREBASE_PROJECTS[i]}" \
    --out="${OPTIONS_DART_FILES[i]}" \
    --yes \
    --platforms="${PLATFORMS[i]}" \
    --android-package-name="${ANDROID_APP_IDS[i]}" \
    --android-out="${ANDROID_OUT_FILES[i]}" \
    --ios-bundle-id="${APPLE_BUNDLE_IDS[i]}" \
    --ios-build-config="${IOS_BUILD_CONFIGS[i]}" \
    --ios-out="${IOS_OUT_FILES[i]}"
done

# jq . file.json | sponge file.json
# Check if sponge is available on Git Bash for Windows
cp firebase.json firebase.json.tmp && \
  jq . firebase.json.tmp > firebase.json && \
  rm firebase.json.tmp
