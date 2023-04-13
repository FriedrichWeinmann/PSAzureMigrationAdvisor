<#
This is an example configuration file

By default, it is enough to have a single one of them,
however if you have enough configuration settings to justify having multiple copies of it,
feel totally free to split them into multiple files.
#>

<#
# Example Configuration
Set-PSFConfig -Module 'PSAzureMigrationAdvisor' -Name 'Example.Setting' -Value 10 -Initialize -Validation 'integer' -Handler { } -Description "Example configuration setting. Your module can then use the setting using 'Get-PSFConfigValue'"
#>

Set-PSFConfig -Module 'PSAzureMigrationAdvisor' -Name 'Import.DoDotSource' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be dotsourced on import. By default, the files of this module are read as string value and invoked, which is faster but worse on debugging."
Set-PSFConfig -Module 'PSAzureMigrationAdvisor' -Name 'Import.IndividualFiles' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be imported individually. During the module build, all module code is compiled into few files, which are imported instead by default. Loading the compiled versions is faster, using the individual files is easier for debugging and testing out adjustments."

Set-PSFConfig -Module 'PSAzureMigrationAdvisor' -Name 'Export.CsvDelimiter' -Value ',' -Initialize -Validation 'string' -Description 'The delimiter to use with "Export-AzScriptReport" when generating CSV files. By default, the current culture will be used.'
Set-PSFConfig -Module 'PSAzureMigrationAdvisor' -Name 'Path.Config' -Value (Join-Path -Path (Get-PSFPath -Name AppData) -ChildPath 'PowerShell/PSAzureMigrationAdvisor') -Initialize -Validation string -Description 'Path where the Azure Migration Advisor looks for its bulk configuration data, such as the mapping data from AzureAD or MSOnline to MSGraph.'
Set-PSFConfig -Module 'PSAzureMigrationAdvisor' -Name 'Path.ModuleRoot' -Value $script:ModuleRoot -Initialize -Validation string -Description 'Path where the module can be found. Used to find the module for automatic background data refreshes.'
Set-PSFConfig -Module 'PSAzureMigrationAdvisor' -Name 'Definitions.AutoUpate.Enabled' -Value $true -Initialize -Validation bool -Description 'Whether the module automatically performs update checks for new definitions mapping AzureAD & MSOnline commands to Graph.'