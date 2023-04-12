function Export-AzScriptReport {
	<#
	.SYNOPSIS
		Exports the results of Read-AzScriptFile to csv or xlsx.
	
	.DESCRIPTION
		Exports the results of Read-AzScriptFile to csv or xlsx.
		It reformats some of the data and eliminates linebreaks in the "Before" column.

		In order to generate xlsx files, the additional module "ImportExcel" is required.
	
	.PARAMETER Path
		The path where to write the report to.
		May be a relative path, must include the filename.
		The parent folder must already exist.
	
	.PARAMETER Delimiter
		Which delimiter to use when generating a CSV file.
		Defaults to the current culture, but may be overridden as needed.
		This affects whether you can open the file in Excel by simple doubleclick or whether you need to first import the data.
	
	.PARAMETER InputObject
		The report objects from Read-AzScriptFile to export.
	
	.EXAMPLE
		PS C:\> Get-ChildItem C:\scripts -Recurse -Filter *.ps1 | Read-AzScriptFile | Export-AzScriptReport -Path .\report.csv
		
		Will search all PowerShell code under C:\scripts, search it for AzureAD and MSOnline commands and then export the finidngs to .\report.csv.
	#>
	[CmdletBinding()]
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		[PsfValidateScript('PSFramework.Validate.FSPath.FileOrParent', ErrorString = 'PSFramework.Validate.FSPath.FileOrParent')]
		[string]
		$Path,

		[string]
		$Delimiter = (Get-PSFConfigValue -FullName 'PSAzureMigrationAdvisor.Export.CsvDelimiter'),

		[Parameter(ValueFromPipeline = $true)]
		$InputObject
	)

	begin {
		$useExcel = $Path -like "*.xlsx"
		if ($useExcel -and -not (Get-Command Export-Excel -ErrorAction Ignore)) {
			Stop-PSFFunction -String 'Export-AzScriptReport.NoExcel' -EnableException $true -Cmdlet $PSCmdlet
		}

		if ($useExcel) {
			$steppable = { Export-Excel -Path $Path }.GetSteppablePipeline()
		}
		else {
			$param = @{ Path = $Path }
			if ($Delimiter) { $param.Delimiter = $Delimiter }
			else { $param.UseCulture = $true }
			$steppable = { Export-Csv @param }.GetSteppablePipeline()
		}

		try { $steppable.Begin($true) }
		catch { Stop-PSFFunction -String 'Export-AzScriptReport.Export.Failed' -StringValues $Path -ErrorRecord $_ -EnableException $true -Cmdlet $PSCmdlet }

		# Ensure mappings for graph commands exist
		if (0 -eq $script:migrationCommandMapping.Count) {
			Import-MappingFile
		}
	}
	process {
		foreach ($datum in $InputObject) {
			#region Process Messages
			# Note: This approach breaks down for messages that had multiple lines
			$msgInfo = @()
			$msgWarning = @()
			$msgError = @()

			$msgTypes = $datum.MessageType -split "`n"
			$messages = $datum.Message -split "`n"

			if ($msgTypes) {
				foreach ($index in 0..$msgTypes.Count) {
					switch (($msgTypes)[$index]) {
						'Info' { $msgInfo += $messages[$index] }
						'Information' { $msgInfo += $messages[$index] }
						'Warning' { $msgWarning += $messages[$index] }
						'Error' { $msgError += $messages[$index] }
					}
				}
			}
			#endregion Process Messages

			$mapped = $script:migrationCommandMapping.$($datum.Command)
			$result = [PSCustomObject][ordered]@{
				Path              = $datum.Path
				Command           = $datum.Command
				CommandLine       = $datum.CommandLine
				Before            = $datum.Before -replace "``[`r`n]+" -replace '\s+', ' ' # Eliminate backticks and linebreaks
				After             = $datum.After
				MsgInfo           = $msgInfo -join "  "
				MsgWarning        = $msgWarning -join "  "
				MsgError          = $msgError -join "  "
				FileHash          = $datum.Filehash
				MessageType       = $datum.MessageType # Keep in the full dataset, just in case somebody includes multiline messages
				Messages          = $datum.Message
				ScopesDelegate    = $mapped.ScopesDelegate -join ','
				ScopesApplication = $mapped.ScopesApplication -join ','
				Examples          = $mapped.LinkExamples -join ', '
				OnlineMapping     = 'https://github.com/microsoft/AzureAD-to-MSGraph/blob/main/docs/{0}/{1}.md' -f $mapped.Module, $mapped.Name
				Organization      = $datum.Organization
				Project           = $datum.Project
				Repository        = $datum.Repository
				Branch            = $datum.Branch
			}
			$steppable.Process($result)
		}
	}
	end {
		$steppable.End()
	}
}