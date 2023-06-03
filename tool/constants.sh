#!/usr/bin/env bash
# shellcheck disable=SC2034

# This shell script is meant to be sourced for constants

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
if shopt -qo pipefail; then PARENT_PIPEFAIL=true; else PARENT_PIPEFAIL=false; fi

set -e -o pipefail

APP_NAME_SNAKE_CASE="space_data_explorer"
APP_NAME_KEBAB_CASE="space-data-explorer"

APPLICATION_ID="dev.hrishikesh_kadam.flutter.$APP_NAME_SNAKE_CASE"

BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"
BUNDLETOOL="java -jar $BUNDLETOOL_PATH"

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
if [ $PARENT_PIPEFAIL = "true" ]; then set -o pipefail; else set +o pipefail; fi
