# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	'Convert-AzScriptFile.Converting'         = 'Applying {0} changes to file {1}' # $results.Count, $filePath
	'Convert-AzScriptFile.Danger.Warning'     = 'This command is dangerous! Almost all converted commands require manual adjustments after renaming them. Use "Read-AzScriptFile" to do a read-only scan and obtain a list of files and locations before converting them. This command is only there to help with and accelerate the manual migration, it is fundamentally unable to guarantee a functional migration on its own. Best prepare a backup of your code before running this command!' # 
	'Convert-AzScriptFile.Path.CommandsFound' = 'Found {0} applicable commands in {1}' # @($relevantTokens).Count, $filePath
	'Convert-AzScriptFile.Path.NoAzCommand'   = 'No applicable commands found in "{0}", skipping file' # $filePath
	'Convert-AzScriptFile.Path.NoScript'      = 'The specified file is not a recognized script file: {0}' # $filePath
	'Convert-AzScriptFile.Path.ResolveError'  = 'Unable to resolve the specified path: {0}' # $pathName

	'Read-AzScriptFile.Path.CommandsFound'    = 'Found {0} applicable commands in {1}' # @($relevantTokens).Count, $filePath
	'Read-AzScriptFile.Path.NoAzCommand'      = 'No applicable commands found in "{0}", skipping file' # $filePath
	'Read-AzScriptFile.Path.NoScript'         = 'The specified file is not a recognized script file: {0}' # $filePath
	'Read-AzScriptFile.Path.ResolveError'     = 'Unable to resolve the specified path: {0}' # $pathName
}