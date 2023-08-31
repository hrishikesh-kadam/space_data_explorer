#!/usr/bin/env bash

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

source ./tool/constants.sh
source ./tool/firebase/source.sh

if [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
  FIREBASE_CHANNEL_ID="pr-$(jq -r .number "$GITHUB_EVENT_PATH")"
  UPLOAD_SOURCEMAPS="false"
elif [[ ! -s ./secrets/.git ]]; then
  FIREBASE_CHANNEL_ID="$BRANCH"
  UPLOAD_SOURCEMAPS="false"
elif [[ $BRANCH != "dev" && $BRANCH != "stag" && $BRANCH != "prod" ]]; then
  FIREBASE_CHANNEL_ID="$BRANCH"
  UPLOAD_SOURCEMAPS="false"
else
  FIREBASE_CHANNEL_ID="live"
  UPLOAD_SOURCEMAPS="true"
fi

_firebase use $FIREBASE_PROJECT_ID
if [[ $FIREBASE_CHANNEL_ID == "live" ]]; then
  _firebase deploy --only hosting
else
  _firebase hosting:channel:deploy "$FIREBASE_CHANNEL_ID" \
    --expires 30d
fi

if [[ $UPLOAD_SOURCEMAPS == "true" ]]; then
  # shellcheck disable=SC1091
  source ./secrets/sentry/source.sh
  sentry-cli releases files upload-sourcemaps \
    ./build/web
fi

rm -f "/tmp/firebase-contri-key.json"
