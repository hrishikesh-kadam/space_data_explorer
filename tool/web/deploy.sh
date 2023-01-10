#!/usr/bin/env bash

set -e

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH == "prod" ]]; then
  FIREBASE_SERVICE_ACCOUNT="$FIREBASE_SERVICE_ACCOUNT_PROD"
  FIREBASE_PROJECT_ID="space-data-explorer"
  FIREBASE_CHANNEL_ID="live"
elif [[ $BRANCH == "stag" ]]; then
  FIREBASE_SERVICE_ACCOUNT="$FIREBASE_SERVICE_ACCOUNT_STAG"
  FIREBASE_PROJECT_ID="space-data-explorer-stag"
  FIREBASE_CHANNEL_ID="live"
elif [[ $BRANCH == "dev" ]]; then
  FIREBASE_SERVICE_ACCOUNT="$FIREBASE_SERVICE_ACCOUNT_DEV"
  FIREBASE_PROJECT_ID="space-data-explorer-dev"
  FIREBASE_CHANNEL_ID="live"
else
  FIREBASE_SERVICE_ACCOUNT="$FIREBASE_SERVICE_ACCOUNT_DEV"
  FIREBASE_PROJECT_ID="space-data-explorer-dev"
  if [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
    FIREBASE_CHANNEL_ID=""
  else
    FIREBASE_CHANNEL_ID="$BRANCH"
  fi
fi

if [[ $GITHUB_ACTIONS == true ]]; then
  {
    echo "FIREBASE_SERVICE_ACCOUNT<<EOF"
    echo "$FIREBASE_SERVICE_ACCOUNT"
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
