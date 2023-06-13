Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

if (-not (Get-Module -ListAvailable PSScriptAnalyzer `
      -ErrorAction SilentlyContinue)) {
  Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
  Install-Module -Name PSScriptAnalyzer
  Get-InstalledModule PSScriptAnalyzer
}
