<#
.SYNOPSIS
	Build file that compiles data files into consolidated files before shipping the module

.DESCRIPTION
	Build file that compiles data files into consolidated files before shipping the module.
	This merges the various data sources that are kept separately for ease of contribution.
#>
param (
	$WorkingDirectory
)

#region Handle Working Directory Defaults
if (-not $WorkingDirectory) {
	if ($env:RELEASE_PRIMARYARTIFACTSOURCEALIAS) {
		$WorkingDirectory = Join-Path -Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY -ChildPath $env:RELEASE_PRIMARYARTIFACTSOURCEALIAS
	}
	else { $WorkingDirectory = $env:SYSTEM_DEFAULTWORKINGDIRECTORY }
}
if (-not $WorkingDirectory) { $WorkingDirectory = Split-Path $PSScriptRoot }
#endregion Handle Working Directory Defaults

$outPath = Join-Path $WorkingDirectory 'PSAzureMigrationAdvisor/data/'
Update-AzADMapping -Force -ConfigRoot $outPath