#!/usr/bin/env bash

# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

./tool/check-line-endings.sh

./tool/shell/analyze.sh

./tool/create.sh

./tool/format-analyze.sh

./tool/test.sh "$FLAVOR_ENV"

./tool/web/build.sh "$FLAVOR_ENV"

# TODO(hrishikesh-kadam): Skip building Android in beta till AGP upgrade is in stable
if flutter --version | grep -q "channel stable"; then
  ./tool/android/build.sh "$FLAVOR_ENV"
fi

if [[ $(uname -s) =~ ^"Darwin" ]]; then
  ./tool/ios/build.sh "$FLAVOR_ENV"
fi

git --no-pager diff
