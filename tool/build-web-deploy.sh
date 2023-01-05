#!/usr/bin/env bash

set -e

source "./tool/set-logs-env.sh"
export PRINT_WARNING_LOG=1

flutter build web --release
mkdir -p ./build/web/.well-known

BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH_NAME == "prod" ]]; then
  cp assets/digital-asset-links/prod/assetlinks.json build/web/.well-known/
  FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER="$FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER_PROD"
  FIREBASE_PROJECT_ID="space-data-explorer"
  FIREBASE_CHANNEL_ID="live"
elif [[ $BRANCH_NAME == "stag" ]]; then
  cp assets/digital-asset-links/stag/assetlinks.json build/web/.well-known/
  FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER="$FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER_STAG"
  FIREBASE_PROJECT_ID="space-data-explorer-stag"
  FIREBASE_CHANNEL_ID="live"
elif [[ $BRANCH_NAME == "dev" ]]; then
  cp assets/digital-asset-links/dev/assetlinks.json build/web/.well-known/
  FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER="$FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER_DEV"
  FIREBASE_PROJECT_ID="space-data-explorer-dev"
  FIREBASE_CHANNEL_ID="live"
else
  cp assets/digital-asset-links/dev/assetlinks.json build/web/.well-known/
  FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER="$FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER_DEV"
  FIREBASE_PROJECT_ID="space-data-explorer-dev"
  if [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
    FIREBASE_CHANNEL_ID=""
  else
    FIREBASE_CHANNEL_ID="$BRANCH_NAME"
  fi
fi

FLUTTER_CHANNEL_OUTPUT=$(flutter channel)
echo "$FLUTTER_CHANNEL_OUTPUT"
if ! echo "$FLUTTER_CHANNEL_OUTPUT" | grep --fixed-strings "* stable" &> /dev/null; then
  warning_log "flutter channel not on stable"
  exit 0
fi

if [[ $GITHUB_ACTIONS == true ]]; then
  {
    echo "FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER<<EOF"
    echo "$FIREBASE_SERVICE_ACCOUNT_SPACE_DATA_EXPLORER"
    echo "EOF"
    echo "FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID"
    echo "FIREBASE_CHANNEL_ID=$FIREBASE_CHANNEL_ID"
  } >> "$GITHUB_ENV"
else
  firebase use $FIREBASE_PROJECT_ID
  if [[ $FIREBASE_CHANNEL_ID == "live" ]]; then
    firebase deploy --only hosting
  else
    firebase hosting:channel:deploy "$FIREBASE_CHANNEL_ID"
  fi
fi
