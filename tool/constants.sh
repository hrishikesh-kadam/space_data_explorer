#!/usr/bin/env bash
# shellcheck disable=SC2034

# This shell script is meant to be sourced for constants

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
if shopt -qo pipefail; then PARENT_PIPEFAIL=true; else PARENT_PIPEFAIL=false; fi

set -e -o pipefail

APP_NAME_SNAKE_CASE="$(yq .name pubspec.yaml)"
APP_NAME_KEBAB_CASE="${APP_NAME_SNAKE_CASE//_/-}"
# shellcheck disable=SC2206
APP_NAME_ARRAY=(${APP_NAME_SNAKE_CASE//_/ })
APP_NAME=${APP_NAME_ARRAY[*]@u}
unset APP_NAME_ARRAY

VERSION="$(yq .version pubspec.yaml)"
VERSION_MAJOR_MINOR_PATCH=${VERSION%+*}

ANDROID_APP_ID_BASE="dev.hrishikesh_kadam.flutter.$APP_NAME_SNAKE_CASE"
APPLE_BUNDLE_ID_BASE="dev.hrishikesh-kadam.flutter.$APP_NAME_KEBAB_CASE"

BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
BUNDLETOOL="java -jar $BUNDLETOOL_PATH"

export SENTRY_ORG="hrishikesh-kadam"
export SENTRY_PROJECT="$APP_NAME_KEBAB_CASE"
export SENTRY_RELEASE="$APP_NAME_KEBAB_CASE@$VERSION_MAJOR_MINOR_PATCH"

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
if [ $PARENT_PIPEFAIL = "true" ]; then set -o pipefail; else set +o pipefail; fi
