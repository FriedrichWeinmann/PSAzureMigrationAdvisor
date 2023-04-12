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

	.PARAMETER Name
		Name of the script to scan
		Used for scenarios where the scanned code is not in a file format (e.g. from Azure DevOps API)

	.PARAMETER Content
		Content/Code of the script to scan
		Used for scenarios where the scanned code is not in a file format (e.g. from Azure DevOps API)
	
	.PARAMETER Type
		What kind of module to migrate.
		Supports scanning for migrating AzureADPreview, AzureAD or Msonline, defaults to scanning AzureADPreview & MSOnline in parallel.

	.PARAMETER TransformPath
		By default, this command uses a predefined set of scanning rules to determine which changes to perform and which warnings to write.
		You can find the rules used in the module's data folder or on Github:
		https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor/tree/master/PSAzureMigrationAdvisor/data

		With this parameter, you can have the tool use instead your own transform/scanning ruleset.
		For more details on how this works and what you can do with it, see the documentation on the Refactor module:
		https://github.com/FriedrichWeinmann/Refactor

		If your own customizations could be viable for a larger audience, please consider filing them as a pull request on this project.

	.PARAMETER ExpandDevOps
		Adds properties to the output for the input's organization, project, repository and branch.
		Only intended for input from scanning Azure DevOps Services repositories using the AzureDevOps.Services.OpenApi module.
	
	.PARAMETER EnableException
		Replaces user friendly yellow warnings with bloody red exceptions of doom!
		Use this if you want the function to throw terminating errors you want to catch.
	
	.EXAMPLE
		PS C:\> Get-ChildItem C:\scripts -Recurse | Read-AzScriptFile

		Scan all files under c:\scripts recursively and get a list of changes to perform and warnings to consider.
	#>
	[CmdletBinding(DefaultParameterSetName = 'Path')]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Path')]
		[Alias('FullName')]
		[string[]]
		$Path,

		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Content')]
		[string]
		$Name,

		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Content')]
		[AllowEmptyString()]
		[string]
		$Content,

		[ValidateSet('AzureADPreview', 'AzureAD', 'MSOnline')]
		[string[]]
		$Type = @('AzureADPreview', 'MSOnline'),

		[string[]]
		$TransformPath,

		[Parameter(ParameterSetName = 'Content')]
		[switch]
		$ExpandDevOps,

		[switch]
		$EnableException
	)

	begin {
		#region Functions
		function Read-ScriptFile {
			[CmdletBinding()]
			param (
				[Refactor.ScriptFile]
				$ScriptFile,

				[string[]]
				$CommandNames,

				[switch]
				$ExpandDevOps
			)

			if ($ExpandDevOps) {
				$splitPath = $ScriptFile.Path -split "/", 4
				$branch = ($ScriptFile.Path -split '\[')[-1].Trim(']')
				$devOpsHash = [ordered]@{
					Organization = $splitPath[0]
					Project      = $splitPath[1]
					Repository   = $splitPath[2]
					Branch       = $branch
				}
			}

			$hashAlgorithm = [System.Security.Cryptography.HashAlgorithm]::Create("MD5")
			$messageParam = @{
				FunctionName = 'Read-AzScriptFile'
				ModuleName   = 'PSAzureMigrationAdvisor'
				Target       = $ScriptFile.Path
			}
			$relevantTokens = $scriptFile.GetTokens() | Where-Object Name -In $CommandNames | Where-Object Type -EQ Command

			if (-not $relevantTokens) {
				Write-PSFMessage @messageParam -String 'Read-AzScriptFile.Path.NoAzCommand' -StringValues $ScriptFile.Path
				return
			}
			$fileBytes = [System.Text.Encoding]::UTF8.GetBytes($scriptFile.Content)
			$fileHash = $hashAlgorithm.ComputeHash($fileBytes).ForEach{ $_.ToString('x2') } -join ""

			Write-PSFMessage @messageParam -String 'Read-AzScriptFile.Path.CommandsFound' -StringValues @($relevantTokens).Count, $ScriptFile.Path

			$results = $scriptFile.Transform($relevantTokens)
			$messagesUsed = [System.Collections.ArrayList]::new()
			foreach ($result in $results.Results) {
				$messages = $results.Messages | Where-Object Token -EQ $result.Token
				$resultHash = [ordered]@{
					PSTypeName  = 'PSAzureMigrationAdvisor.ScanResult'
					Path        = $result.Path
					Command     = $result.Token -replace '^Command -> '
					CommandLine = $result.Token.Ast.Extent.StartLineNumber
					Before      = $result.Change.Before
					After       = $result.Change.After
					Message     = $messages.Text -join "`n"
					MessageType = $messages.Type -join "`n"
					FileHash    = $fileHash
				}
				if ($ExpandDevOps) { $resultHash += $devOpsHash }
				[PSCustomObject]$resultHash
				foreach ($message in $messages) {
					$null = $messagesUsed.Add($message)
				}
			}
			foreach ($message in $results.Messages) {
				# If messages were found that are not associated to a resultant token
				if ($message -in $messagesUsed) { continue }

				$resultHash = [ordered]@{
					PSTypeName  = 'PSAzureMigrationAdvisor.ScanResult'
					Path        = $results.Path
					Command     = $message.Data.Name
					CommandLine = $message.Token.Ast.Extent.StartLineNumber
					Before      = ''
					After       = ''
					Message     = $message.Text
					MessageType = $message.Type
					FileHash    = $fileHash
				}
				if ($ExpandDevOps) { $resultHash += $devOpsHash }
				[PSCustomObject]$resultHash
			}
		}
		#endregion Functions

		Clear-ReTokenTransformationSet
		if ($TransformPath) {
			Import-ReTokenTransformationSet -Path $TransformPath
		}
		else {
			Import-MappingFile -Type $Type
		}
		
		$commandNames = (Get-ReTokenTransformationSet).Name
	}
	process {
		#region Process by Path
		foreach ($pathName in $Path) {
			try { $paths = Resolve-PSFPath -Path $pathName -Provider FileSystem }
			catch {
				Stop-PSFFunction -String 'Read-AzScriptFile.Path.ResolveError' -StringValues $pathName -EnableException $EnableException -ErrorRecord $_ -Tag path -Target $pathName -Continue -Cmdlet $PSCmdlet
			}
			
			#region Process individual files
			foreach ($filePath in $paths) {
				if ($filePath -notmatch '\.ps1$|\.psm1|.psf1') {
					Write-PSFMessage -Level Warning -String 'Read-AzScriptFile.Path.NoScript' -StringValues $filePath -Target $filePath
					continue
				}

				$scriptFile = Get-ReScriptFile -Path $filePath
				Read-ScriptFile -ScriptFile $scriptFile -CommandNames $commandNames
			}
			#endregion Process individual files
		}
		#endregion Process by Path

		#region Process by Name & Content
		if ($Name -and $Content) {
			$scriptFile = Get-ReScriptFile -Name $Name -Content $Content
			Read-ScriptFile -ScriptFile $scriptFile -CommandNames $commandNames -ExpandDevOps:$ExpandDevOps
		}
		#endregion Process by Name & Content
	}
	end {
		Clear-ReTokenTransformationSet
	}
}