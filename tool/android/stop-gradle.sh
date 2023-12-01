#!/usr/bin/env bash

set -e -o pipefail

pushd android &> /dev/null
./gradlew --stop
popd &> /dev/null
