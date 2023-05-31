#!/usr/bin/env bash

set -e -o pipefail

LATEST_JSON=$( \
  curl -sL "https://api.github.com/repos/google/bundletool/releases/latest"
)
echo "LATEST_JSON=$LATEST_JSON"
VERSION=$(echo "$LATEST_JSON" | jq -r .name)
echo "VERSION=$VERSION"
BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
curl -o "$BUNDLETOOL_PATH" \
  -sL "https://github.com/google/bundletool/releases/download/$VERSION/bundletool-all-$VERSION.jar"
openssl sha256 "$BUNDLETOOL_PATH"
printf "bundletool "
java -jar "$BUNDLETOOL_PATH" version
