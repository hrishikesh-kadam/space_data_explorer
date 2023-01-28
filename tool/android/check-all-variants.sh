#!/usr/bin/env bash

set -e -o pipefail
# TODO(hrishikesh-kadam): Check this on Windows
if [[ $(uname -s) =~ ^"MINGW" ]]; then
  set +e +o pipefail
fi

pushd android &> /dev/null
CURRENT_VARIANTS=$(./gradlew -q printAllVariants | csv2md)
diff --unified --color all-variants.md <(echo "$CURRENT_VARIANTS")
popd &> /dev/null
