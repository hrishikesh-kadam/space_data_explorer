#!/usr/bin/env bash

# $1 FLAVOR_ENV dev, stag, prod.

set -e -o pipefail

FLAVOR_ENV=$1

pushd android &> /dev/null
APPLICATION_ID=$(./gradlew \
  -q :app:getApplicationId \
  -PvariantName="${FLAVOR_ENV}Release")
popd &> /dev/null

TRACK=$(./tool/android/get-track-from-flavor-env.sh "$FLAVOR_ENV")

pushd android &> /dev/null
PLAY_VERSION_CODE=$(
  bundle exec fastlane get_play_version_code \
    package_name:"$APPLICATION_ID" \
    track:"$TRACK" \
    | grep --only-matching --extended-regexp "PLAY_VERSION_CODE=[0-9]+" \
    | cut -d = -f2
)
popd &> /dev/null

echo "$PLAY_VERSION_CODE"
