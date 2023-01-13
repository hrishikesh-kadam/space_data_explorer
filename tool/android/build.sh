#!/usr/bin/env bash

set -e

pushd android &> /dev/null
./gradlew build
popd &> /dev/null

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH != "dev" && \
  $BRANCH != "stag" && \
  $BRANCH != "prod" ]]; then
  FLAVOR="dev"
else
  FLAVOR=$BRANCH
fi

flutter build appbundle --flavor "$FLAVOR"
