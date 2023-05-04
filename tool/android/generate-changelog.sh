#!/usr/bin/env bash

# $1 FLAVOR_ENV
# $2 VERSION_CODE
# $3 VERSION_NAME

set -e -o pipefail

FLAVOR_ENV=$1
VERSION_CODE=$2
VERSION_NAME=$3

if [[ $FLAVOR_ENV == "prod" ]]; then
  exit 0
fi

CHANGELOG_FILE="./android/fastlane/$FLAVOR_ENV/metadata/android/en-US/changelogs/default.txt"
printf "" > "$CHANGELOG_FILE"

if [[ -n $VERSION_CODE && -n $VERSION_NAME ]]; then
  echo "# $VERSION_CODE ($VERSION_NAME)" > "$CHANGELOG_FILE"
fi

CHANGELOG_COMMITS=$(git log -10 --format="- %s")
echo "$CHANGELOG_COMMITS" >> "$CHANGELOG_FILE"
