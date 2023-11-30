#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.
#   $2 VERSION_CODE Optional
#   $3 VERSION_NAME Optional

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi
PRINT_WARNING_LOG=1

FLAVOR_ENV=${1:?"Missing argument \$1 FLAVOR_ENV dev / stag / prod."}
VERSION_CODE=$2
VERSION_NAME=$3

CHANGELOG_DIRECTORY="./android/fastlane/$FLAVOR_ENV/metadata/android/en-US/changelogs"
mkdir -p "$CHANGELOG_DIRECTORY"
CHANGELOG_FILE="$CHANGELOG_DIRECTORY/default.txt"

if [[ $FLAVOR_ENV == "dev" || $FLAVOR_ENV == "stag" ]]; then
  printf "" > "$CHANGELOG_FILE"
  if [[ -n $VERSION_CODE && -n $VERSION_NAME ]]; then
    echo "# $VERSION_CODE ($VERSION_NAME)" > "$CHANGELOG_FILE"
  fi
  CHANGELOG_COMMITS=$(git log -10 --format="- %s")
  echo "$CHANGELOG_COMMITS" >> "$CHANGELOG_FILE"
fi

if (( $(wc -c < "$CHANGELOG_FILE") > 500 )); then
  TRUNCATED_CHANGELOG_FILE="$CHANGELOG_DIRECTORY/default_truncated.txt"
  head -c 497 "$CHANGELOG_FILE" > "$TRUNCATED_CHANGELOG_FILE"
  printf "..." >> "$TRUNCATED_CHANGELOG_FILE"
  mv "$TRUNCATED_CHANGELOG_FILE" "$CHANGELOG_FILE"
  log_warning "$CHANGELOG_FILE truncated to 500 length"
fi
