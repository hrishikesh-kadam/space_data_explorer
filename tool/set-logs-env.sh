# shellcheck shell=sh

# This shell script is mean to be sourced for printing colorful logs

export PRINT_WARNING_LOG=0
export PRINT_INFO_LOG=0
export PRINT_DEBUG_LOG=0

print_in_red() {
  printf "%b\n" "\033[31m$*\033[0m"
}

print_in_yellow() {
  printf "%b\n" "\033[33m$*\033[0m"
}

print_in_green() {
  printf "%b\n" "\033[32m$*\033[0m"
}

print_in_cyan() {
  printf "%b\n" "\033[36m$*\033[0m"
}

error_log() {
  print_in_red "ERROR: $*" >&2
}

warning_log() {
  if [ $PRINT_WARNING_LOG -eq 1 ]; then
    print_in_yellow "WARNING: $*"
  fi
}

info_log() {
  if [ $PRINT_INFO_LOG -eq 1 ]; then
    print_in_green "INFO: $*"
  fi
}

debug_log() {
  if [ $PRINT_DEBUG_LOG -eq 1 ]; then
    print_in_cyan "DEBUG: $*"
  fi
}

#######################################
# Print $1 as error message and exit with $2 as status
# Arguments:
#   $1 - Error message
#   $2 - Exit status
# Returns:
#   $2 argument
#######################################
error_with_help() {
  error_log "$1"
  echo "Use -h or --help for details." >&2
  exit "$2"
}
