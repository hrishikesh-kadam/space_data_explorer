# shellcheck shell=sh

# This shell script is meant to be sourced for printing colorful logs

if [ -z ${-%*e*} ]; then PARENT_ERREXIT=true; else PARENT_ERREXIT=false; fi

set -e

export PRINT_WARNING_LOG=0
export PRINT_INFO_LOG=0
export PRINT_DEBUG_LOG=0

print_in_red() {
  printf "%b%s%b\n" "\033[31m" "$*" "\033[0m"
}

print_in_yellow() {
  printf "%b%s%b\n" "\033[33m" "$*" "\033[0m"
}

print_in_green() {
  printf "%b%s%b\n" "\033[32m" "$*" "\033[0m"
}

print_in_cyan() {
  printf "%b%s%b\n" "\033[36m" "$*" "\033[0m"
}

log_error() {
  print_in_red "Error: $*" >&2
}

log_warning() {
  if [ $PRINT_WARNING_LOG -eq 1 ]; then
    print_in_yellow "Warning: $*"
  fi
}

log_info() {
  if [ $PRINT_INFO_LOG -eq 1 ]; then
    print_in_green "Info: $*"
  fi
}

log_debug() {
  if [ $PRINT_DEBUG_LOG -eq 1 ]; then
    print_in_cyan "Debug: $*"
  fi
}

#######################################
# Print $1 as error log and exit with $2 as status
# Arguments:
#   $1 - Error log
#   $2 - Exit status
# Returns:
#   $2 argument
#######################################
log_error_with_exit() {
  log_error "$1"
  exit "$2"
}

#######################################
# Print $1 as error log, print help details and exit with $2 as status
# Arguments:
#   $1 - Error log
#   $2 - Exit status
# Returns:
#   $2 argument
#######################################
log_error_with_help() {
  log_error "$1"
  echo "Use -h or --help for details." >&2
  exit "$2"
}

if [ $PARENT_ERREXIT = "true" ]; then set -e; else set +e; fi
