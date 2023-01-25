#!/usr/bin/env bash

# This shell script is meant to be sourced for constants

if [[ -o errexit ]]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi
set -e

export APP_NAME_SNAKE_CASE="space_data_explorer"
export APP_NAME_KEBAB_CASE="space-data-explorer"

export APPLICATION_ID="dev.hrishikesh_kadam.flutter.$APP_NAME_SNAKE_CASE"

export BUNDLETOOL_PATH="$ANDROID_HOME/bundletool-all.jar"

$PARENT_ERREXIT || set +e
