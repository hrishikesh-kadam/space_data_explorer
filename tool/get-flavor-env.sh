#!/usr/bin/env bash

set -e

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH != "dev" && \
  $BRANCH != "stag" && \
  $BRANCH != "prod" ]]; then
  FLAVOR_ENV="dev"
else
  FLAVOR_ENV=$BRANCH
fi

echo "$FLAVOR_ENV"
