function Read-AzScriptFile {
	<#
	.SYNOPSIS
		Scans scriptfiles for required changes to migrate from AzureAD or Msonline to Microsoft.Graph.
	
	.DESCRIPTION
		Scans scriptfiles for required changes to migrate from AzureAD or Msonline to Microsoft.Graph.

		Does not apply any changes, returns one entry per change needed, plus one for each message - error, warning or info - generated from a given file.
		
		Note:
		This scan uses the Refactor module's system of transforms to perform the scan, more details on that
		can be found on the project site:
		https://github.com/FriedrichWeinmann/Refactor

		The transform files used _by default_ can be found in the data sub-folder of this module:
		https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor/tree/master/PSAzureMigrationAdvisor/data
		Use the -TransformPath parameter to override this with your own transforms if desired.
	
	.PARAMETER Path
		Path to the script-file(s) to scan
	
	.PARAMETER Type
		What kind of module to migrate.
		Supports scanning for migrating AzureAD or Msonline, defaults to scanning both in parallel.

	.PARAMETER TransformPath
		By default, this command uses a predefined set of scanning rules to determine which changes to perform and which warnings to write.
		You can find the rules used in the module's data folder or on Github:
		https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor/tree/master/PSAzureMigrationAdvisor/data

		With this parameter, you can have the tool use instead your own transform/scanning ruleset.
		For more details on how this works and what you can do with it, see the documentation on the Refactor module:
		https://github.com/FriedrichWeinmann/Refactor

		If your own customizations could be viable for a larger audience, please consider filing them as a pull request on this project.
	
	.PARAMETER EnableException
		Replaces user friendly yellow warnings with bloody red exceptions of doom!
		Use this if you want the function to throw terminating errors you want to catch.
	
	.EXAMPLE
		PS C:\> Get-ChildItem C:\scripts -Recurse | Read-AzScriptFile

		Scan all files under c:\scripts recursively and get a list of changes to perform and warnings to consider.
	#>
	[CmdletBinding(DefaultParameterSetName = 'preset')]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('FullName')]
		[string[]]
		$Path,

		[Parameter(ParameterSetName = 'preset')]
		[ValidateSet('AzureAD', 'MSOnline')]
		[string[]]
		$Type = @('AzureAD', 'MSOnline'),

		[Parameter(Mandatory = $true, ParameterSetName = 'custom')]
		[string[]]
		$TransformPath,

		[switch]
		$EnableException
	)

	begin {
		Clear-ReTokenTransformationSet
		if ($TransformPath) {
			Import-ReTokenTransformationSet -Path $TransformPath
		}
		else {
			if ($Type -contains 'AzureAD') { Import-ReTokenTransformationSet -Path "$script:ModuleRoot\data\azureAD-to-graph.psd1" }
			if ($Type -contains 'MSOnline') { Import-ReTokenTransformationSet -Path "$script:ModuleRoot\data\msol-to-graph.psd1" }
		}
		
		$commandNames = (Get-ReTokenTransformationSet).Name
	}
	process {
		foreach ($pathName in $Path) {
			try { $paths = Resolve-PSFPath -Path $pathName -Provider FileSystem }
			catch {
				Stop-PSFFunction -String 'Read-AzScriptFile.Path.ResolveError' -StringValues $pathName -EnableException $EnableException -ErrorRecord $_ -Tag path -Target $pathName -Continue -Cmdlet $PSCmdlet
			}
			
			#region Process individual files
			foreach ($filePath in $paths) {
				if ($filePath -notmatch '\.ps1$|\.psm1') {
					Write-PSFMessage -Level Warning -String 'Read-AzScriptFile.Path.NoScript' -StringValues $filePath -Target $filePath
					continue
				}

				$scriptFile = Get-ReScriptFile -Path $filePath
				$relevantTokens = $scriptFile.GetTokens() | Where-Object Name -In $commandNames | Where-Object Type -EQ Command

				if (-not $relevantTokens) {
					Write-PSFMessage -String 'Read-AzScriptFile.Path.NoAzCommand' -StringValues $filePath -Target $filePath
					continue
				}

				Write-PSFMessage -String 'Read-AzScriptFile.Path.CommandsFound' -StringValues @($relevantTokens).Count, $filePath -Target $filePath

				$results = $scriptFile.Transform($relevantTokens)
				foreach ($result in $results.Results) {
					[PSCustomObject]@{
						PSTypeName  = 'PSAzureMigrationAdvisor.ScanResult'
						Path        = $result.Path
						Command     = $result.Token -replace '^Command -> '
						CommandLine = $result.Token.Ast.Extent.StartLineNumber
						Before      = $result.Change.Before
						After       = $result.Change.After
						Message     = ''
						MessageType = ''
					}
				}
				foreach ($message in $results.Messages) {
					[PSCustomObject]@{
						PSTypeName  = 'PSAzureMigrationAdvisor.ScanResult'
						Path        = $results.Path
						Command     = $message.Data.Name
						CommandLine = $message.Token.Ast.Extent.StartLineNumber
						Before      = ''
						After       = ''
						Message     = $message.Text
						MessageType = $message.Type
					}
				}
			}
			#endregion Process individual files
		}
	}
	end {
		Clear-ReTokenTransformationSet
	}
}