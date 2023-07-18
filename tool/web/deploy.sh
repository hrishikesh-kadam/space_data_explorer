#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

source ./tool/constants.sh

BRANCH="$(git rev-parse --abbrev-ref HEAD)"

if [[ ! -s ./secrets/.git ]]; then
  if [[ -n $FIREBASE_CONTRI_KEY ]]; then
    echo "$FIREBASE_CONTRI_KEY" > "/tmp/firebase-contri-key.json"
    GOOGLE_APPLICATION_CREDENTIALS="/tmp/firebase-contri-key.json"
  fi
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-contri"
elif [[ $BRANCH == "stag" ]]; then
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/service-accounts/firebase-stag-key.json"
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-stag"
elif [[ $BRANCH == "prod" ]]; then
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/service-accounts/firebase-prod-key.json"
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}"
else
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/service-accounts/firebase-dev-key.json"
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-dev"
fi

if [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
  FIREBASE_CHANNEL_ID="pr-$(jq -r .number "$GITHUB_EVENT_PATH")"
elif [[ ! -s ./secrets/.git ]]; then
  FIREBASE_CHANNEL_ID="$BRANCH"
elif [[ $BRANCH != "dev" && $BRANCH != "stag" && $BRANCH != "prod" ]]; then
  FIREBASE_CHANNEL_ID="$BRANCH"
else
  FIREBASE_CHANNEL_ID="live"
fi

_firebase() {
  if [[ $GITHUB_ACTIONS == "true" ]]; then
    GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS firebase "$@"
  else
    firebase "$@"
  fi
}

_firebase use $FIREBASE_PROJECT_ID
if [[ $FIREBASE_CHANNEL_ID == "live" ]]; then
  _firebase deploy --only hosting
else
  _firebase hosting:channel:deploy "$FIREBASE_CHANNEL_ID" \
    --expires 30d
fi

rm -f "/tmp/firebase-contri-key.json"
