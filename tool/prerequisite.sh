#!/usr/bin/env bash

# $1 ROLE (--minimal / --contributor / --member), defaults to --member

set -e -o pipefail

source ./tool/shell/logs-env.sh

check_command_on_path() {
  if [[ ! -x $(command -v "$1") ]]; then
    log_error_with_exit "$1 command not accessible from PATH" 1
  fi
}

check_directory_on_path() {
  local directory=$1
  if [[ $(uname -s) =~ ^"MINGW" ]]; then
    directory=$(cygpath "$directory")
  fi
  if [[ ! $PATH =~ $directory ]]; then
    log_error_with_exit "$1 directory not found on PATH" 1
  fi
}

ROLE=${1//--}
: "${ROLE:=member}"

check_command_on_path flutter
if ! export -p | grep "declare -x FLUTTER_ROOT=" &> /dev/null; then
  log_error_with_exit "FLUTTER_ROOT exported variable not found" 1
fi

if [[ $(uname -s) =~ ^"Darwin" ]]; then
  check_command_on_path brew
elif [[ $(uname -s) =~ ^"MINGW" ]]; then
  check_command_on_path pwsh
  if ! pwsh -NoProfile ./tool/shell/is-admin.ps1; then
    log_error_with_exit "Please run this script from Elevated Session" 1
  fi
  if [[ ! $GITHUB_ACTIONS ]]; then
    # winget is not yet available in GitHub Actions
    check_command_on_path winget
    WINGET_LINKS_PATH_WIN="$LOCALAPPDATA\Microsoft\WinGet\Links"
    WINGET_LINKS_PATH_NIX=$(cygpath "$WINGET_LINKS_PATH_WIN")
    if [[ ! $PATH =~ $WINGET_LINKS_PATH_NIX ]]; then
      if [[ $GITHUB_ACTIONS == "true" ]]; then
        echo "$WINGET_LINKS_PATH_WIN" >> "$GITHUB_PATH"
        PATH="$WINGET_LINKS_PATH_NIX:$PATH"
      else
        # Deliberately avoiding to set PATH by setx command
        log_error_with_exit "$WINGET_LINKS_PATH_NIX directory not found on PATH" 1
      fi
    fi
  fi
  check_command_on_path choco
fi

if [[ $(uname -s) =~ ^"MINGW" ]]; then
  pwsh -NoProfile ./tool/prerequisite.ps1
fi

if [[ ! -x $(command -v dos2unix) ]]; then
  if [[ $(uname -s) =~ ^"Linux" ]]; then
    sudo apt install dos2unix
  elif [[ $(uname -s) =~ ^"Darwin" ]]; then
    brew install dos2unix
  fi
  dos2unix --version
fi

if [[ ! -x $(command -v shellcheck) ]]; then
  if [[ $(uname -s) =~ ^"Linux" ]]; then
    sudo apt install shellcheck
  elif [[ $(uname -s) =~ ^"Darwin" ]]; then
    brew install shellcheck
  elif [[ $(uname -s) =~ ^"MINGW" ]]; then
    if [[ $GITHUB_ACTIONS == "true" ]]; then
      choco install shellcheck
    else
      winget install koalaman.shellcheck
    fi
  fi
  shellcheck --version
fi

check_command_on_path java
JAVA_CLASS_MAJOR_VERSION=$( \
  javap -verbose java.lang.String \
    | grep "major version" \
    | cut -d " " -f 5 \
)
: "${JAVA_CLASS_MAJOR_VERSION:=-1}"
if (( "$JAVA_CLASS_MAJOR_VERSION" < 55 )); then
  log_error "JDK 11 not found on PATH"
  JAVA_VERSION_OUTPUT="$(java --version)"
  print_in_red "$JAVA_VERSION_OUTPUT"
  exit 1
fi

if [[ ! -x $(command -v pipx) ]]; then
  if [[ $(uname -s) =~ ^"Linux" ]]; then
    sudo apt install pipx
    pipx --version
    pipx ensurepath
  elif [[ $(uname -s) =~ ^"Darwin" ]]; then
    brew install pipx
    pipx --version
    pipx ensurepath
  elif [[ $(uname -s) =~ ^"MINGW" ]]; then
    log_error_with_exit "pipx command not accessible from PATH" 1
  fi
fi

if [[ ! -x $(command -v csv2md) ]]; then
  pipx install csv2md
fi

if [[ ! -x $(command -v lcov) ]]; then
  if [[ $(uname -s) =~ ^"Linux" ]]; then
    sudo apt install lcov
  elif [[ $(uname -s) =~ ^"Darwin" ]]; then
    brew install lcov
  elif [[ $(uname -s) =~ ^"MINGW" ]]; then
    choco install lcov
    : "${ChocolateyInstall:=C:\ProgramData\chocolatey}"
    LCOV_ROOT_WIN="$ChocolateyInstall\lib\lcov\tools\bin"
    LCOV_ROOT_NIX=$(cygpath "$LCOV_ROOT_WIN")
    if [[ ! $PATH =~ $LCOV_ROOT_NIX ]]; then
      if [[ $GITHUB_ACTIONS == "true" ]]; then
        echo "$LCOV_ROOT_WIN" >> "$GITHUB_PATH"
        PATH="$LCOV_ROOT_NIX:$PATH"
      else
        # Deliberately avoiding to set PATH by setx command
        log_error_with_exit "$LCOV_ROOT_NIX directory not found on PATH" 1
      fi
    fi
  fi
  lcov --version
fi

if [[ $(uname -s) =~ ^"Darwin" ]]; then
  if ! diff --version | grep "diff (GNU diffutils) 3" &> /dev/null; then
    brew install diffutils
    diff --version
  fi
fi

if [[ ! -x $(command -v jq) ]]; then
  if [[ $(uname -s) =~ ^"Linux" ]]; then
    sudo apt install jq
  elif [[ $(uname -s) =~ ^"Darwin" ]]; then
    brew install jq
  elif [[ $(uname -s) =~ ^"MINGW" ]]; then
    if [[ $GITHUB_ACTIONS == "true" ]]; then
      choco install jq
    else
      winget install jqlang.jq
    fi
  fi
  jq --version
fi

if [[ ! -x $(command -v yq) ]]; then
  if [[ $(uname -s) =~ ^"Linux" ]]; then
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
      -O /usr/bin/yq
    sudo chmod +x /usr/bin/yq
  elif [[ $(uname -s) =~ ^"Darwin" ]]; then
    brew install yq
  elif [[ $(uname -s) =~ ^"MINGW" ]]; then
    if [[ $GITHUB_ACTIONS == "true" ]]; then
      choco install yq
    else
      winget install MikeFarah.yq
    fi
  fi
  yq --version
fi

if ! export -p | grep "declare -x ANDROID_HOME=" &> /dev/null; then
  log_error_with_exit "ANDROID_HOME exported variable not found" 1
fi

if [[ ! -s "$ANDROID_HOME/bundletool-all.jar" ]]; then
  ./tool/android/install-bundletool.sh
fi

check_command_on_path node
check_command_on_path npm
NPM_CONFIG_PREFIX="$(npm config get prefix)"
if [[ $(uname -s) =~ ^"MINGW" ]]; then
  check_directory_on_path "$NPM_CONFIG_PREFIX"
else
  check_directory_on_path "$NPM_CONFIG_PREFIX/bin"
fi

if [[ ! -x $(command -v chromedriver) ]]; then
  npm install -g chromedriver --detect_chromedriver_version
  chromedriver --version
fi

if [[ $ROLE == "contributor" || $ROLE == "member" ]]; then
  if [[ ! -x $(command -v firebase) ]]; then
    npm install -g firebase-tools
    printf "firebase "
    firebase --version
  fi
  # if [[ ! -x $(command -v flutterfire) ]]; then
  #   dart pub global activate flutterfire_cli ^0.3.0-dev.18
  #   CI=true flutterfire --version
  # fi
  if [[ ! -x $(command -v sentry-cli) ]]; then
    npm install -g @sentry/cli
    sentry-cli --version
  fi
fi

if [[ $ROLE == "member" ]]; then
  check_command_on_path ruby
  check_command_on_path gem
  check_command_on_path bundle
  
  pushd android &> /dev/null
  BUNDLE_CHECK_OUTPUT=$(bundle check) || true
  if [[ $BUNDLE_CHECK_OUTPUT != "The Gemfile's dependencies are satisfied" ]]; then
    bundle install
  else
    if [[ $GITHUB_ACTIONS == "true" ]]; then
      echo "$BUNDLE_CHECK_OUTPUT"
    fi
  fi
  popd &> /dev/null
fi

if [[ $(uname -s) =~ ^"Darwin" ]]; then
  if [[ ! -x $(command -v pod) ]]; then
    brew install cocoapods
    pod --version
  fi
fi
