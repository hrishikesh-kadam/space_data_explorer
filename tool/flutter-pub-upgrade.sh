#!/usr/bin/env bash

set -e -o pipefail

flutter pub upgrade

pushd ios &> /dev/null
pod update
popd &> /dev/null
