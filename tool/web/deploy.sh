#!/usr/bin/env bash

set -e -o pipefail

source ./tool/constants.sh

BRANCH="$(git rev-parse --abbrev-ref HEAD)"

if [[ ! -d ./secrets ]]; then
  if [[ -n $FIREBASE_SERVICE_ACCOUNT_CONTRI ]]; then
    echo "$FIREBASE_SERVICE_ACCOUNT_CONTRI" > /tmp/firebase-service-account-contri.json
    GOOGLE_APPLICATION_CREDENTIALS="/tmp/firebase-service-account-contri.json"
  fi
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-contri"
elif [[ $BRANCH == "stag" ]]; then
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/firebase-service-account-stag.json"
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-stag"
elif [[ $BRANCH == "prod" ]]; then
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/firebase-service-account-prod.json"
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}"
else
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/firebase-service-account-dev.json"
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-dev"
fi

if [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
  FIREBASE_CHANNEL_ID="pr-$(jq .number "$GITHUB_EVENT_PATH")"
elif [[ ! -d ./secrets ]]; then
  FIREBASE_CHANNEL_ID="$BRANCH"
elif [[ $BRANCH != "dev" && $BRANCH != "stag" && $BRANCH != "prod" ]]; then
  FIREBASE_CHANNEL_ID="$BRANCH"
else
  FIREBASE_CHANNEL_ID="live"
fi

if [[ $GITHUB_ACTION ]]; then
  FIREBASE="GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS firebase"
else
  FIREBASE="firebase"
fi

$FIREBASE use $FIREBASE_PROJECT_ID
if [[ $FIREBASE_CHANNEL_ID == "live" ]]; then
  $FIREBASE deploy --only hosting
else
  $FIREBASE hosting:channel:deploy "$FIREBASE_CHANNEL_ID" \
    --expires 30d
fi

rm -f /tmp/firebase-service-account-contri.json
