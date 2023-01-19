#!/usr/bin/env bash

set -e

pushd android &> /dev/null
./gradlew build
popd &> /dev/null

FLAVOR=$(./tool/android/get-flavor.sh)

flutter build appbundle --flavor "$FLAVOR"
