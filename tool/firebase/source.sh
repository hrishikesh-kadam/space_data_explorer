#!/usr/bin/env bash

# This shell script is meant to be sourced.
# Arguments:
#   $1 FLAVOR_ENV dev / stag / prod.

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
if shopt -qo pipefail; then PARENT_PIPEFAIL=true; else PARENT_PIPEFAIL=false; fi

set -e -o pipefail

if [[ $LOGS_ENV_SOURCED != "true" ]]; then
  source ./tool/shell/logs-env.sh
fi

FLAVOR_ENV=${1:?\
$(print_in_red "Missing argument \$1 FLAVOR_ENV dev / stag / prod.")}

source ./tool/constants.sh

if [[ ! -s ./secrets/.git ]]; then
  if [[ -n $FIREBASE_CONTRI_KEY ]]; then
    echo "$FIREBASE_CONTRI_KEY" > "/tmp/firebase-contri-key.json"
    GOOGLE_APPLICATION_CREDENTIALS="/tmp/firebase-contri-key.json"
  fi
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-contri"
elif [[ $FLAVOR_ENV == "prod" ]]; then
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/service-accounts/firebase-prod-key.json"
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}"
elif [[ $FLAVOR_ENV == "stag" ]]; then
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/service-accounts/firebase-stag-key.json"
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-stag"
else
  GOOGLE_APPLICATION_CREDENTIALS="./secrets/web/service-accounts/firebase-dev-key.json"
  # shellcheck disable=SC2034
  FIREBASE_PROJECT_ID="${APP_NAME_KEBAB_CASE}-dev"
fi

_firebase() {
  if [[ $GITHUB_ACTIONS == "true" ]]; then
    GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS firebase "$@"
  else
    firebase "$@"
  fi
}

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
if [ $PARENT_PIPEFAIL = "true" ]; then set -o pipefail; else set +o pipefail; fi
