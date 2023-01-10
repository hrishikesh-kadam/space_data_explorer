#!/usr/bin/env bash

set -e

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH != "prod" && \
  $BRANCH != "stag" && \
  $BRANCH != "dev" ]]; then
  FLAVOR="dev"
else
  FLAVOR=$BRANCH
fi

flutter build appbundle --flavor "$FLAVOR"
