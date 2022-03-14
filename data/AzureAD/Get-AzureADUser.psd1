@{
	'Get-AzureADUser' = @{
		Name            = 'Get-AzureADUser'
		NewName         = 'Get-MgUser'
		Parameters      = @{
			ObjectId     = 'UserId'
			SearchString = 'Search'
		}
		ErrorParameters = @{
			All = 'The "-All" parameter is a switch parameter in the graph module and does not expect a value anymore. "-All $true" would now be "-All". It can also no longer be combined with the "-ObjectId"/"-UserId" parameter.'
		}
	}
}