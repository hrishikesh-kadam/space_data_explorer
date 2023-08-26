#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

source ./tool/constants.sh
source ./tool/firebase/init.sh

if [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
  FIREBASE_CHANNEL_ID="pr-$(jq -r .number "$GITHUB_EVENT_PATH")"
elif [[ ! -s ./secrets/.git ]]; then
  FIREBASE_CHANNEL_ID="$BRANCH"
elif [[ $BRANCH != "dev" && $BRANCH != "stag" && $BRANCH != "prod" ]]; then
  FIREBASE_CHANNEL_ID="$BRANCH"
else
  FIREBASE_CHANNEL_ID="live"
fi

_firebase use $FIREBASE_PROJECT_ID
if [[ $FIREBASE_CHANNEL_ID == "live" ]]; then
  _firebase deploy --only hosting
else
  _firebase hosting:channel:deploy "$FIREBASE_CHANNEL_ID" \
    --expires 30d
fi

rm -f "/tmp/firebase-contri-key.json"
