Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$admin = $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($admin) {
  exit 0
} else {
  exit 1
}
