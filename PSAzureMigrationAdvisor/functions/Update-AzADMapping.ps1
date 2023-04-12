function Update-AzADMapping {
	<#
	.SYNOPSIS
		Updates Azure AD to Microsoft Graph API command mapping data.

	.DESCRIPTION
		The Update-AzADMapping function retrieves the command mapping data from GitHub and saves it in a local directory.
		If the local data is up-to-date, the function exits without performing any action.

	.PARAMETER ConfigRoot
		Specifies the root directory where the mapping data is stored.
		If this parameter is not provided, the value of the PSAzureMigrationAdvisor.Path.Config configuration setting is used instead.

	.PARAMETER Force
		Perform the update, no matter whether the local definitions are already up-to-date or not.

	.EXAMPLE
		PS C:\> Update-AzADMapping -ConfigRoot "C:\AzureADMapping"

		This command updates the Azure AD to Microsoft Graph API command mapping data stored in the C:\AzureADMapping directory.
		If the directory does not exist, the function creates it.

	.LINK
		https://github.com/microsoft/AzureAD-to-MSGraph

#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
	[CmdletBinding()]
	param (
		[string]
		$ConfigRoot = (Get-PSFConfigValue -FullName 'PSAzureMigrationAdvisor.Path.Config'),

		[switch]
		$Force
	)

	if (-not (Test-Path -Path $ConfigRoot)) {
		$null = New-Item -Path $ConfigRoot -ItemType Directory -Force
	}

	$timestampUrl = 'https://github.com/microsoft/AzureAD-to-MSGraph/raw/main/export/timestamp.clidat'
	$definitionUrl = 'https://github.com/microsoft/AzureAD-to-MSGraph/raw/main/export/all.clidat'
	$localTimestampPath = Join-Path -Path $ConfigRoot -ChildPath timestamp.clidat

	try {
		$timestampOnline = (Invoke-WebRequest -Uri $timestampUrl).Content | ConvertFrom-PSFClixml
	}
	catch {
		Stop-PSFFunction -String 'Update-AzADMapping.Internet.Error' -ErrorRecord $_ -Cmdlet $PSCmdlet -EnableException $true
	}
	$timestampLocal = Get-Date -Date 1970-01-01
	if (Test-Path -Path "$script:ModuleRoot\data\timestamp.clidat") {
		$timestampLocal = Import-PSFClixml -Path "$script:ModuleRoot\data\timestamp.clidat"
	}
	if (Test-Path -Path $localTimestampPath) {
		$timestampLocal = Import-PSFClixml -Path $localTimestampPath
	}

	if (-not $Force -and $timestampLocal -ge $timestampOnline) { return }

	$dataEntries = (Invoke-WebRequest -Uri $definitionUrl).Content | ConvertFrom-PSFClixml
	$dataEntries | Export-PSFClixml -Path (Join-Path -Path $ConfigRoot -ChildPath 'raw-data.clidat')

	foreach ($moduleGroup in $dataEntries | Group-Object Module) {
		$result = @{
			Version = 1
			Type    = 'Command'
			Content = @{ }
		}

		foreach ($commandDefinition in $moduleGroup.Group) {
			$data = @{
				Name    = $commandDefinition.Name
				NewName = $commandDefinition.NewCommand
			}
			$paramRemap = @{}
			$paramInfo = @{}
			$paramWarn = @{}
			$paramError = @{}
			foreach ($param in $commandDefinition.Parameters.Values) {
				if ($param.NewName -and $param.Name -ne $param.NewName) { $paramRemap[$param.Name] = $param.NewName }
				if ($param.MsgInfo) { $paramInfo[$param.Name] = $param.MsgInfo }
				if ($param.MsgWarning) { $paramWarn[$param.Name] = $param.MsgWarning }
				if ($param.MsgError) { $paramError[$param.Name] = $param.MsgError }
			}
			if (0 -lt $paramRemap.Count) { $data.Parameters = $paramRemap }
			if (0 -lt $paramInfo.Count) { $data.InfoParameters = $paramInfo }
			if (0 -lt $paramWarn.Count) { $data.WarningParameters = $paramWarn }
			if (0 -lt $paramError.Count) { $data.ErrorParameters = $paramError }

			$result.Content[$data.Name] = $data
		}

		$moduleExportPath = Join-Path -Path $ConfigRoot -ChildPath "definition-$($moduleGroup.Name).json"
		$result | ConvertTo-Json -Depth 5 -Compress | Set-Content -Path $moduleExportPath
	}

	$timestampOnline | Export-PSFClixml -Path $localTimestampPath
}