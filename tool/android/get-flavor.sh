#!/usr/bin/env bash

set -e

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH != "dev" && \
  $BRANCH != "stag" && \
  $BRANCH != "prod" ]]; then
  FLAVOR="dev"
else
  FLAVOR=$BRANCH
fi

echo "$FLAVOR"
