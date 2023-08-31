#!/usr/bin/env bash

set -e -o pipefail

source ./tool/shell/logs-env.sh
# source ./tool/constants.sh

./tool/web/deploy.sh

if [[ $GITHUB_EVENT_NAME != "pull_request" ]]; then
  ./tool/android/publish.sh

  # source ./secrets/sentry/source.sh
  # dart run sentry_dart_plugin
fi

git status -s
