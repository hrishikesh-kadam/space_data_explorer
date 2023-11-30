#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

CHANGELOG_DIRECTORY="./ios/fastlane/$FLAVOR_ENV/metadata/en-US"
mkdir -p "$CHANGELOG_DIRECTORY"
CHANGELOG_FILE="$CHANGELOG_DIRECTORY/release_notes.txt"

if [[ $FLAVOR_ENV == "dev" || $FLAVOR_ENV == "stag" ]]; then
  printf "" > "$CHANGELOG_FILE"
  CHANGELOG_COMMITS=$(git log -10 --format="- %s")
  echo "$CHANGELOG_COMMITS" >> "$CHANGELOG_FILE"
fi

if (( $(wc -c < "$CHANGELOG_FILE") > 4000 )); then
  TRUNCATED_CHANGELOG_FILE="$CHANGELOG_DIRECTORY/release_notes_truncated.txt"
  head -c 3997 "$CHANGELOG_FILE" > "$TRUNCATED_CHANGELOG_FILE"
  printf "..." >> "$TRUNCATED_CHANGELOG_FILE"
  mv "$TRUNCATED_CHANGELOG_FILE" "$CHANGELOG_FILE"
  log_warning "$CHANGELOG_FILE truncated to 500 length"
fi
