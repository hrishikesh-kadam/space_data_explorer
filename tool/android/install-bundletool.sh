#!/usr/bin/env bash

set -e -o pipefail

VERSION=$( \
  curl -s "https://api.github.com/repos/google/bundletool/releases/latest" \
    | jq -r .name
)
BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
curl -o "$BUNDLETOOL_PATH" \
  -sL "https://github.com/google/bundletool/releases/download/$VERSION/bundletool-all-$VERSION.jar"
printf "bundletool "
java -jar "$BUNDLETOOL_PATH" version
