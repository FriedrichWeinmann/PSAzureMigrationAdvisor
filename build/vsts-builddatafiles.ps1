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

#region AzureAD Migration
$rawString = @'
@{
	Type = 'Command'
	Version = 1
	Content = @{
DATA
	}
}
'@
$lines = foreach ($file in Get-ChildItem -Path (Join-Path $WorkingDirectory 'data/AzureAD')) {
	Get-Content -LiteralPath $file.FullName | Where-Object { $_ -and $_ -notin '@{', '}' } | Add-String "`t" ''
}
$newText = $rawString -replace 'DATA', ($lines -join "`n")
$outPath = Join-Path $WorkingDirectory 'PSAzureMigrationAdvisor/data/azureAD-to-graph.psd1'
$encoding = [System.Text.UTF8Encoding]::new($true)
[System.IO.File]::WriteAllText($outPath, $newText, $encoding)
#endregion AzureAD Migration

#region MSOnline Migration
$rawString = @'
@{
	Type = 'Command'
	Version = 1
	Content = @{
DATA
	}
}
'@
$lines = foreach ($file in Get-ChildItem -Path (Join-Path $WorkingDirectory 'data/MSOnline')) {
	Get-Content -LiteralPath $file.FullName | Where-Object { $_ -and $_ -notin '@{', '}' } | Add-String "`t" ''
}
$newText = $rawString -replace 'DATA', ($lines -join "`n")
$outPath = Join-Path $WorkingDirectory 'PSAzureMigrationAdvisor/data/msol-to-graph.psd1'
$encoding = [System.Text.UTF8Encoding]::new($true)
[System.IO.File]::WriteAllText($outPath, $newText, $encoding)
#endregion MSOnline Migration