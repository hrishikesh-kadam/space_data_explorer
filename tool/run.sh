#!/usr/bin/env bash

# $1 commands like ./tool/shell/analyze.sh or ./tool/android/build.sh, which 
#    requires some source scripts

set -e -o pipefail

source ./tool/shell/logs-env.sh

$1
