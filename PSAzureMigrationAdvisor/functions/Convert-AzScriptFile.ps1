function Convert-AzScriptFile {
	<#
	.SYNOPSIS
		Converts scripts to use the Microsoft.Graph commands from using AzureAD or Msonline.
	
	.DESCRIPTION
		Converts scripts to use the Microsoft.Graph commands from using AzureAD or Msonline.
		
		WARNING! WARNING! WARNING!
		Migration REQUIRES manual intervention!
		Almost all commands have different parameter signatures that often cannot be automatically converted.
		Or some commands are split into two commands.
		Or some commands offer only partial functionality afterwards.

		Use Read-AzScriptFile to get a list of all places where you need to adjust things.
		This command really is only there so you don't have to do the part we already can automate,
		but alone this will not be enough!
	
	.PARAMETER Path
		Path to the script-file(s) to convert.
	
	.PARAMETER Type
		What kind of module to migrate.
		Supports scanning for migrating AzureAD or Msonline, defaults to scanning both at the same time.

	.PARAMETER TransformPath
		By default, this command uses a predefined set of scanning rules to determine which changes to perform and which warnings to write.
		You can find the rules used in the module's data folder or on Github:
		https://github.com/FriedrichWeinmann/PSAzureMigrationAdvisor/tree/master/PSAzureMigrationAdvisor/data

		With this parameter, you can have the tool use instead your own transform/scanning ruleset.
		For more details on how this works and what you can do with it, see the documentation on the Refactor module:
		https://github.com/FriedrichWeinmann/Refactor

		If your own customizations could be viable for a larger audience, please consider filing them as a pull request on this project.

	.PARAMETER OutPath
		Folder to which to write the converted scriptfile.
	
	.PARAMETER EnableException
		Replaces user friendly yellow warnings with bloody red exceptions of doom!
		Use this if you want the function to throw terminating errors you want to catch.

	.PARAMETER WhatIf
		If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

	.PARAMETER Confirm
		If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.
	
	.EXAMPLE
		PS C:\> Get-ChildItem C:\scripts -Recurse | Convert-AzScriptFile

		Migrate all files under c:\scripts recursively and get a list of changes to perform and warnings to consider.
		You may want to create a backup before doing this.
		Also consider the messages written!
	#>
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High', DefaultParameterSetName = 'preset')]
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

		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'path')]
		[PsfValidateScript('PSFramework.Validate.FSPath.Folder', ErrorString = 'PSFramework.Validate.FSPath.Folder')]
		[string]
		$OutPath,

		[switch]
		$EnableException
	)

	begin {
		Write-PSFMessage -String 'Convert-AzScriptFile.Danger.Warning' -Once Danger -Level Warning

		Clear-ReTokenTransformationSet
		if ($TransformPath) {
			Import-ReTokenTransformationSet -Path $TransformPath
		}
		else {
			Import-MappingFile -Type $Type
		}
		
		$commandNames = (Get-ReTokenTransformationSet).Name

		$lastResolvedPath = ""
	}
	process {
		if ($OutPath -ne $lastResolvedPath) {
			$resolvedOutPath = Resolve-PSFPath -Path $OutPath
			$lastResolvedPath = $OutPath
		}

		foreach ($pathName in $Path) {
			try { $paths = Resolve-PSFPath -Path $pathName -Provider FileSystem }
			catch {
				Stop-PSFFunction -String 'Convert-AzScriptFile.Path.ResolveError' -StringValues $pathName -EnableException $EnableException -ErrorRecord $_ -Tag path -Target $pathName -Continue -Cmdlet $PSCmdlet
			}
			
			#region Process individual files
			foreach ($filePath in $paths) {
				if ($filePath -notmatch '\.ps1$|\.psm1$|\.psf1$') {
					Write-PSFMessage -Level Warning -String 'Convert-AzScriptFile.Path.NoScript' -StringValues $filePath -Target $filePath
					continue
				}

				$scriptFile = Get-ReScriptFile -Path $filePath
				$relevantTokens = $scriptFile.GetTokens() | Where-Object Name -In $commandNames | Where-Object Type -EQ Command

				if (-not $relevantTokens) {
					Write-PSFMessage -String 'Convert-AzScriptFile.Path.NoAzCommand' -StringValues $filePath -Target $filePath
					continue
				}

				Write-PSFMessage -String 'Convert-AzScriptFile.Path.CommandsFound' -StringValues @($relevantTokens).Count, $filePath -Target $filePath

				try { $results = $scriptFile.Transform($relevantTokens) }
				catch { Stop-PSFFunction -String 'Convert-AzScriptFile.Converting.Error' -StringValues $filePath -ErrorRecord $_ -EnableException $EnableException -Continue -Target $filePath }

				if ($OutPath) {
					Invoke-PSFProtectedCommand -ActionString 'Convert-AzScriptFile.ConvertingWriting' -ActionStringValues $results.Count, $filePath, $resolvedOutPath -ScriptBlock {
						$scriptfile.WriteTo($resolvedOutPath, "")
					} -Target $filePath -EnableException $EnableException -PSCmdlet $PSCmdlet -Continue
				}
				else {
					Invoke-PSFProtectedCommand -ActionString 'Convert-AzScriptFile.Converting' -ActionStringValues $results.Count, $filePath -ScriptBlock {
						$scriptFile.Save($false)
					} -Target $filePath -EnableException $EnableException -PSCmdlet $PSCmdlet -Continue
				}
				$results
			}
			#endregion Process individual files
		}
	}
	end {
		Clear-ReTokenTransformationSet
	}
}