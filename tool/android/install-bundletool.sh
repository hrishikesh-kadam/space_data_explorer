#!/usr/bin/env bash

set -e

VERSION=$( \
  curl -s "https://api.github.com/repos/google/bundletool/releases/latest" \
    | jq .name -r
)
curl -o "$ANDROID_HOME/bundletool-all.jar" \
  -sL "https://github.com/google/bundletool/releases/download/$VERSION/bundletool-all-$VERSION.jar"
