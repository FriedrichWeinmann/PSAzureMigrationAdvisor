if (Get-PSFConfigValue -FullName 'PSAzureMigrationAdvisor.Definitions.AutoUpate.Enabled') {
	Register-PSFTaskEngineTask -Name PSAzureMigrationAdvisor.UpdateCheck -ScriptBlock {
		$moduleRoot = Get-PSFConfigValue -FullName 'PSAzureMigrationAdvisor.Path.ModuleRoot'
		Import-Module (Join-Path -Path $moduleRoot -ChildPath 'PSAzureMigrationAdvisor.psd1') -Scope Global

		Update-AzADMapping
	} -Description 'Looks for the latest definition set of AzureAD/MSOnline to Graph mappings' -Once
}