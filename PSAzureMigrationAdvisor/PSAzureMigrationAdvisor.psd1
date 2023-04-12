@{
	# Script module or binary module file associated with this manifest
	RootModule = 'PSAzureMigrationAdvisor.psm1'
	
	# Version number of this module.
	ModuleVersion = '1.2.11'
	
	# ID used to uniquely identify this module
	GUID = 'f3cb2750-2108-4462-a86b-e542d12370c8'
	
	# Author of this module
	Author = 'Friedrich Weinmann'
	
	# Company or vendor of this module
	CompanyName = ' '
	
	# Copyright statement for this module
	Copyright = 'Copyright (c) 2022 Friedrich Weinmann'
	
	# Description of the functionality provided by this module
	Description = 'Tools to help migrate scripts using the official Azure/AzureAD modules'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '5.1'
	
	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules = @(
		@{ ModuleName='PSFramework'; ModuleVersion='1.7.270' }
		@{ ModuleName='Refactor'; ModuleVersion='1.1.18' }
	)
	
	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @('bin\PSAzureMigrationAdvisor.dll')
	
	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @('xml\PSAzureMigrationAdvisor.Types.ps1xml')
	
	# Format files (.ps1xml) to be loaded when importing this module
	FormatsToProcess = @('xml\PSAzureMigrationAdvisor.Format.ps1xml')
	
	# Functions to export from this module
	FunctionsToExport = @(
		'Convert-AzScriptFile'
		'Export-AzScriptReport'
		'Read-AzScriptFile'
		'Update-AzADMapping'
	)
	
	# Cmdlets to export from this module
	# CmdletsToExport = ''
	
	# Variables to export from this module
	# VariablesToExport = ''
	
	# Aliases to export from this module
	# AliasesToExport = ''
	
	# List of all modules packaged with this module
	ModuleList = @()
	
	# List of all files packaged with this module
	FileList = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			Tags = @('refactor','migration','ast','scripting')
			
			# A URL to the license for this module.
			LicenseUri = 'https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor/blob/master/LICENSE'
			
			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor'
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			ReleaseNotes = 'https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor/blob/master/PSAzureMigrationAdvisor/changelog.md'
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}