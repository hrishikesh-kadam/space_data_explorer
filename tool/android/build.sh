#!/usr/bin/env bash

set -e

./tool/android/android-gradle-checkAllVariants.sh

pushd android &> /dev/null
./gradlew build
popd &> /dev/null

FLAVOR=$(./tool/android/get-flavor.sh)

flutter build appbundle --flavor "$FLAVOR"
