#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

if [[ $GITHUB_EVENT_NAME == "pull_request" ]]; then
  log_error_with_exit "./tool/cd.sh script is not supposed to be trigerred from Pull Request"
fi

./tool/web/deploy.sh "$FLAVOR_ENV"

./tool/android/publish.sh "$FLAVOR_ENV"

# source ./secrets/sentry/source.sh
# dart run sentry_dart_plugin

if [[ $(uname -s) =~ ^"Darwin" ]]; then
  ./tool/ios/deploy.sh "$FLAVOR_ENV"
fi

git --no-pager diff
