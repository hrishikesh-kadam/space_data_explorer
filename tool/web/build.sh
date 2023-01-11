#!/usr/bin/env bash

set -e

flutter build web --release
mkdir -p ./build/web/.well-known

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH != "dev" && \
  $BRANCH != "stag" && \
  $BRANCH != "prod" ]]; then
  APP_ENV="dev"
else
  APP_ENV=$BRANCH
fi

cp "assets/digital-asset-links/$APP_ENV/assetlinks.json" "build/web/.well-known/"
