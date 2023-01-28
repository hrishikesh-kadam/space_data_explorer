#!/usr/bin/env bash

set -e -o pipefail

FLAVOR_ENV=$(./tool/get-flavor-env.sh)

flutter build appbundle --flavor "$FLAVOR_ENV"

./tool/android/check-all-variants.sh

pushd android &> /dev/null
./gradlew app:build
popd &> /dev/null
