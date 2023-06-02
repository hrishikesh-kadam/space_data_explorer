#!/usr/bin/env bash

set -e -o pipefail

if [[ $GITHUB_ACTIONS == "true" ]]; then
  # To avoid GitHub API rate limiting
  VERSION=$( \
    curl --silent --show-error --location --fail \
      --output /dev/null \
      --write-out "%{url_effective}" \
      https://github.com/google/bundletool/releases/latest \
      | xargs basename
  )
else
  VERSION=$( \
    curl --silent --show-error --location --fail \
      "https://api.github.com/repos/google/bundletool/releases/latest" \
      | jq -r .name
  )
fi
BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
curl --silent --show-error --location --fail \
  --output "$BUNDLETOOL_PATH" \
  "https://github.com/google/bundletool/releases/download/$VERSION/bundletool-all-$VERSION.jar"
printf "bundletool "
java -jar "$BUNDLETOOL_PATH" version
