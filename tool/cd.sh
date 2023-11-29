#!/usr/bin/env bash

set -e -o pipefail

source ./tool/shell/logs-env.sh

if [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
  log_error_with_exit "./tool/cd.sh script is not supposed to be trigerred from Pull Request" 1
fi

./tool/web/deploy.sh

./tool/android/publish.sh

# source ./secrets/sentry/source.sh
# dart run sentry_dart_plugin

if [[ $(uname -s) =~ ^"Darwin" ]]; then
  ./tool/ios/deploy.sh
fi

git status -s
