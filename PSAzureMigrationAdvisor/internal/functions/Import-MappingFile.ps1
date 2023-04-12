function Import-MappingFile {
	<#
		.SYNOPSIS
			Imports a mapping file for a specified resource type.

		.DESCRIPTION
			The Import-MappingFile cmdlet imports a mapping file for a specified resource type, which contains a set of ReToken transformations that can be used to migrate Azure Active Directory (Azure AD) PowerShell scripts to Microsoft Graph PowerShell scripts.
			The cmdlet searches for the mapping file in the configuration directory specified by the PSAzureMigrationAdvisor.Path.Config configuration value.
			If the mapping file is not found, the cmdlet searches for it in the module data directory.

		.PARAMETER Type
			Specifies an array of resource types to import.

		.EXAMPLE
			PS C:> Import-MappingFile -Type AzureADPreview, MSOnline

			Imports the mapping files for the 'AzureADPreview' and 'MSOnline' resource types.
#>
	[CmdletBinding()]
	param (
		[string[]]
		$Type
	)

	$configRoot = Get-PSFConfigValue -FullName 'PSAzureMigrationAdvisor.Path.Config'
	$moduleDataRoot = Join-Path -Path $script:ModuleRoot -ChildPath 'data'

	# Update the Token Transformation Sets
	foreach ($typeName in $Type) {
		Write-PSFMessage -Message "Loading definitions for $typeName"
		if (Test-Path -Path (Join-Path -Path $configRoot -ChildPath "definition-$typeName.json")) {
			Import-ReTokenTransformationSet -Path (Join-Path -Path $configRoot -ChildPath "definition-$typeName.json")
		}
		else {
			Import-ReTokenTransformationSet -Path (Join-Path -Path $moduleDataRoot -ChildPath "definition-$typeName.json")
		}
	}

	# Update the global command dataset
	if (Test-Path -Path (Join-Path -Path $configRoot -ChildPath "raw-data.clidat")) {
		$data = Import-PSFCLixml -Path (Join-Path -Path $configRoot -ChildPath "raw-data.clidat")
	}
	else {
		$data = Import-PSFCLixml -Path (Join-Path -Path $moduleDataRoot -ChildPath "raw-data.clidat")
	}

	$commands = @{}
	foreach ($command in $data) {
		$commands[$command.Name] = $command
		if (-not $command.NewCommand) { continue }
		foreach ($newCommand in $command.NewCommand) {
			$commands[$newCommand] = $command
		}
	}

	$script:migrationCommandMapping = $commands
}