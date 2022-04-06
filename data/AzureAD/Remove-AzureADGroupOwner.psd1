@{
    'Remove-AzureADGroupOwner' = @{
		Name     = 'Remove-AzureADGroupOwner'
		MsgWarning = "No Graph counterpart known for Remove-AzureADGroupOwner
Use Invoke-MgGraphRequest to custom execute 'groups/{id}/owners/{id}/`$ref' as documented here:
https://docs.microsoft.com/en-us/graph/api/group-delete-owners?view=graph-rest-1.0&tabs=http"
	}
}