#!/usr/bin/env bash
# shellcheck disable=SC2034

# This shell script is meant to be sourced for constants

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
if shopt -qo pipefail; then PARENT_PIPEFAIL=true; else PARENT_PIPEFAIL=false; fi

set -e -o pipefail

APP_NAME_SNAKE_CASE="$(yq .name pubspec.yaml)"
APP_NAME_KEBAB_CASE="space-data-explorer"

VERSION="$(yq .version pubspec.yaml)"

ANDROID_APP_ID="dev.hrishikesh_kadam.flutter.$APP_NAME_SNAKE_CASE"

BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
BUNDLETOOL="java -jar $BUNDLETOOL_PATH"

export SENTRY_ORG="hrishikesh-kadam"
export SENTRY_PROJECT="$APP_NAME_KEBAB_CASE"
export SENTRY_RELEASE="$APP_NAME_KEBAB_CASE@$VERSION"

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
if [ $PARENT_PIPEFAIL = "true" ]; then set -o pipefail; else set +o pipefail; fi
