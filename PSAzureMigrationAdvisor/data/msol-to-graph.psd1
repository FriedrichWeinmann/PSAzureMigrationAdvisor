@{
	Version = 1
	Type    = 'Command'
	Content = @{
		'Add-MsolAdministrativeUnitMember'                    = @{
			Name    = 'Add-MsolAdministrativeUnitMember'
			NewName = 'New-MgDirectoryAdministrativeUnitMemberByRef'
		}
		'Add-MsolForeignGroupToRole'                          = @{
			Name     = 'Add-MsolForeignGroupToRole'
			MsgError = 'No Graph counterpart known for Add-MsolForeignGroupToRole'
		}
		'Add-MsolGroupMember'                                 = @{
			Name    = 'Add-MsolGroupMember'
			NewName = 'New-MgGroupMember'
		}
		'Add-MsolRoleMember'                                  = @{
			Name    = 'Add-MsolRoleMember'
			NewName = 'New-MgDirectoryRoleMemberByRef'
		}
		'Add-MsolScopedRoleMember'                            = @{
			Name    = 'Add-MsolScopedRoleMember'
			NewName = 'New-MgDirectoryRoleScopedMember'
		}
		'Confirm-MsolDomain'                                  = @{
			Name    = 'Confirm-MsolDomain'
			NewName = 'Confirm-MgDomain'
		}
		'Confirm-MsolEmailVerifiedDomain'                     = @{
			Name     = 'Confirm-MsolEmailVerifiedDomain'
			MsgError = 'No Graph counterpart known for Confirm-MsolEmailVerifiedDomain'
		}
		'Connect-MsolService'                                 = @{
			Name    = 'Connect-MsolService'
			NewName = 'Connect-MgGraph'
		}
		'Convert-MsolDomainToFederated'                       = @{
			Name     = 'Convert-MsolDomainToFederated'
			MsgError = 'No Graph counterpart known for Convert-MsolDomainToFederated'
		}
		'Convert-MsolDomainToStandard'                        = @{
			Name     = 'Convert-MsolDomainToStandard'
			MsgError = 'No Graph counterpart known for Convert-MsolDomainToStandard'
		}
		'Convert-MsolFederatedUser'                           = @{
			Name     = 'Convert-MsolFederatedUser'
			MsgError = 'No Graph counterpart known for Convert-MsolFederatedUser'
		}
		'Disable-MsolDevice'                                  = @{
			Name     = 'Disable-MsolDevice'
			MsgError = 'No Graph counterpart known for Disable-MsolDevice'
		}
		'Enable-MsolDevice'                                   = @{
			Name     = 'Enable-MsolDevice'
			MsgError = 'No Graph counterpart known for Enable-MsolDevice'
		}
		'Get-MsolAccountSku'                                  = @{
			Name    = 'Get-MsolAccountSku'
			NewName = 'Get-MgSubscribedSku'
		}
		'Get-MsolAdministrativeUnit'                          = @{
			Name    = 'Get-MsolAdministrativeUnit'
			NewName = 'Get-MgDirectoryAdministrativeUnit'
		}
		'Get-MsolAdministrativeUnitMember'                    = @{
			Name    = 'Get-MsolAdministrativeUnitMember'
			NewName = 'Get-MgDirectoryAdministrativeUnitMember'
		}
		'Get-MsolCompanyAllowedDataLocation'                  = @{
			Name     = 'Get-MsolCompanyAllowedDataLocation'
			MsgError = 'No Graph counterpart known for Get-MsolCompanyAllowedDataLocation'
		}
		'Get-MsolCompanyInformation'                          = @{
			Name    = 'Get-MsolCompanyInformation'
			NewName = 'Get-MgOrganization'
		}
		'Get-MsolContact'                                     = @{
			Name    = 'Get-MsolContact'
			NewName = 'Get-MgContract'
		}
		'Get-MsolDevice'                                      = @{
			Name    = 'Get-MsolDevice'
			NewName = 'Get-MgDevice'
		}
		'Get-MsolDeviceRegistrationServicePolicy'             = @{
			Name     = 'Get-MsolDeviceRegistrationServicePolicy'
			MsgError = 'No Graph counterpart known for Get-MsolDeviceRegistrationServicePolicy'
		}
		'Get-MsolDirSyncConfiguration'                        = @{
			Name     = 'Get-MsolDirSyncConfiguration'
			MsgError = 'No Graph counterpart known for Get-MsolDirSyncConfiguration'
		}
		'Get-MsolDirSyncFeatures'                             = @{
			Name     = 'Get-MsolDirSyncFeatures'
			MsgError = 'No Graph counterpart known for Get-MsolDirSyncFeatures'
		}
		'Get-MsolDirSyncProvisioningError'                    = @{
			Name     = 'Get-MsolDirSyncProvisioningError'
			MsgError = 'No Graph counterpart known for Get-MsolDirSyncProvisioningError'
		}
		'Get-MsolDomain'                                      = @{
			Name    = 'Get-MsolDomain'
			NewName = 'Get-MgDomain'
		}
		'Get-MsolDomainFederationSettings'                    = @{
			Name     = 'Get-MsolDomainFederationSettings'
			MsgError = 'No Graph counterpart known for Get-MsolDomainFederationSettings'
		}
		'Get-MsolDomainVerificationDns'                       = @{
			Name    = 'Get-MsolDomainVerificationDns'
			NewName = 'Get-MgDomainVerificationDnsRecord'
		}
		'Get-MsolFederationProperty'                          = @{
			Name     = 'Get-MsolFederationProperty'
			MsgError = 'No Graph counterpart known for Get-MsolFederationProperty'
		}
		'Get-MsolGroup'                                       = @{
			Name    = 'Get-MsolGroup'
			NewName = 'Get-MgGroup'
		}
		'Get-MsolGroupMember'                                 = @{
			Name    = 'Get-MsolGroupMember'
			NewName = 'Get-MgGroupMember'
		}
		'Get-MsolHasObjectsWithDirSyncProvisioningErrors'     = @{
			Name     = 'Get-MsolHasObjectsWithDirSyncProvisioningErrors'
			MsgError = 'No Graph counterpart known for Get-MsolHasObjectsWithDirSyncProvisioningErrors'
		}
		'Get-MsolPartnerContract'                             = @{
			Name     = 'Get-MsolPartnerContract'
			MsgError = 'No Graph counterpart known for Get-MsolPartnerContract'
		}
		'Get-MsolPartnerInformation'                          = @{
			Name     = 'Get-MsolPartnerInformation'
			MsgError = 'No Graph counterpart known for Get-MsolPartnerInformation'
		}
		'Get-MsolPasswordPolicy'                              = @{
			Name     = 'Get-MsolPasswordPolicy'
			MsgError = 'No Graph counterpart known for Get-MsolPasswordPolicy'
		}
		'Get-MsolRole'                                        = @{
			Name    = 'Get-MsolRole'
			NewName = 'Get-MgDirectoryRole'
		}
		'Get-MsolRoleMember'                                  = @{
			Name    = 'Get-MsolRoleMember'
			NewName = 'Get-MgDirectoryRoleMember'
		}
		'Get-MsolScopedRoleMember'                            = @{
			Name    = 'Get-MsolScopedRoleMember'
			NewName = 'Get-MgDirectoryRoleScopedMember'
		}
		'Get-MsolServicePrincipal'                            = @{
			Name    = 'Get-MsolServicePrincipal'
			NewName = 'Get-MgServicePrincipal'
		}
		'Get-MsolServicePrincipalCredential'                  = @{
			Name     = 'Get-MsolServicePrincipalCredential'
			MsgError = 'No Graph counterpart known for Get-MsolServicePrincipalCredential'
		}
		'Get-MsolSubscription'                                = @{
			Name    = 'Get-MsolSubscription'
			NewName = 'Get-MgSubscription'
		}
		'Get-MsolUser'                                        = @{
			Name    = 'Get-MsolUser'
			NewName = 'Get-MgUser'
		}
		'Get-MsolUserByStrongAuthentication'                  = @{
			Name     = 'Get-MsolUserByStrongAuthentication'
			MsgError = 'No Graph counterpart known for Get-MsolUserByStrongAuthentication'
		}
		'Get-MsolUserRole'                                    = @{
			Name    = 'Get-MsolUserRole'
			NewName = 'Get-MgUserMemberOf'
		}
		'New-MsolAdministrativeUnit'                          = @{
			Name    = 'New-MsolAdministrativeUnit'
			NewName = 'New-MgDirectoryAdministrativeUnit'
		}
		'New-MsolDomain'                                      = @{
			Name    = 'New-MsolDomain'
			NewName = 'New-MgDomain'
		}
		'New-MsolFederatedDomain'                             = @{
			Name     = 'New-MsolFederatedDomain'
			MsgError = 'No Graph counterpart known for New-MsolFederatedDomain'
		}
		'New-MsolGroup'                                       = @{
			Name    = 'New-MsolGroup'
			NewName = 'New-MgGroup'
		}
		'New-MsolLicenseOptions'                              = @{
			Name     = 'New-MsolLicenseOptions'
			MsgError = 'No Graph counterpart known for New-MsolLicenseOptions'
		}
		'New-MsolServicePrincipal'                            = @{
			Name    = 'New-MsolServicePrincipal'
			NewName = 'New-MgServicePrincipal'
		}
		'New-MsolServicePrincipalAddresses'                   = @{
			Name     = 'New-MsolServicePrincipalAddresses'
			MsgError = 'No Graph counterpart known for New-MsolServicePrincipalAddresses'
		}
		'New-MsolServicePrincipalCredential'                  = @{
			Name     = 'New-MsolServicePrincipalCredential'
			MsgError = 'No Graph counterpart known for New-MsolServicePrincipalCredential'
		}
		'New-MsolUser'                                        = @{
			Name    = 'New-MsolUser'
			NewName = 'New-MgUser'
		}
		'New-MsolWellKnownGroup'                              = @{
			Name     = 'New-MsolWellKnownGroup'
			MsgError = 'No Graph counterpart known for New-MsolWellKnownGroup'
		}
		'Redo-MsolProvisionContact'                           = @{
			Name     = 'Redo-MsolProvisionContact'
			MsgError = 'No Graph counterpart known for Redo-MsolProvisionContact'
		}
		'Redo-MsolProvisionGroup'                             = @{
			Name     = 'Redo-MsolProvisionGroup'
			MsgError = 'No Graph counterpart known for Redo-MsolProvisionGroup'
		}
		'Redo-MsolProvisionUser'                              = @{
			Name     = 'Redo-MsolProvisionUser'
			MsgError = 'No Graph counterpart known for Redo-MsolProvisionUser'
		}
		'Remove-MsolAdministrativeUnit'                       = @{
			Name    = 'Remove-MsolAdministrativeUnit'
			NewName = 'Remove-MgDirectoryAdministrativeUnit'
		}
		'Remove-MsolAdministrativeUnitMember'                 = @{
			Name    = 'Remove-MsolAdministrativeUnitMember'
			NewName = 'Remove-MgDirectoryAdministrativeUnitScopedRoleMember'
		}
		'Remove-MsolApplicationPassword'                      = @{
			Name    = 'Remove-MsolApplicationPassword'
			NewName = 'Remove-MgApplicationPassword'
		}
		'Remove-MsolContact'                                  = @{
			Name    = 'Remove-MsolContact'
			NewName = 'Remove-MgContact'
		}
		'Remove-MsolDevice'                                   = @{
			Name    = 'Remove-MsolDevice'
			NewName = 'Remove-MgDevice'
		}
		'Remove-MsolDomain'                                   = @{
			Name    = 'Remove-MsolDomain'
			NewName = 'Remove-MgDomain'
		}
		'Remove-MsolFederatedDomain'                          = @{
			Name     = 'Remove-MsolFederatedDomain'
			MsgError = 'No Graph counterpart known for Remove-MsolFederatedDomain'
		}
		'Remove-MsolForeignGroupFromRole'                     = @{
			Name     = 'Remove-MsolForeignGroupFromRole'
			MsgError = 'No Graph counterpart known for Remove-MsolForeignGroupFromRole'
		}
		'Remove-MsolGroup'                                    = @{
			Name    = 'Remove-MsolGroup'
			NewName = 'Remove-MgGroup'
		}
		'Remove-MsolGroupMember'                              = @{
			Name     = 'Remove-MsolGroupMember'
			MsgError = 'No Graph counterpart known for Remove-MsolGroupMember'
		}
		'Remove-MsolRoleMember'                               = @{
			Name     = 'Remove-MsolRoleMember'
			MsgError = 'No Graph counterpart known for Remove-MsolRoleMember'
		}
		'Remove-MsolScopedRoleMember'                         = @{
			Name    = 'Remove-MsolScopedRoleMember'
			NewName = 'Remove-MgDirectoryRoleScopedMember'
		}
		'Remove-MsolServicePrincipal'                         = @{
			Name    = 'Remove-MsolServicePrincipal'
			NewName = 'Remove-MgServicePrincipal'
		}
		'Remove-MsolServicePrincipalCredential'               = @{
			Name     = 'Remove-MsolServicePrincipalCredential'
			MsgError = 'No Graph counterpart known for Remove-MsolServicePrincipalCredential'
		}
		'Remove-MsolUser'                                     = @{
			Name    = 'Remove-MsolUser'
			NewName = 'Remove-MgUser'
		}
		'Reset-MsolStrongAuthenticationMethodByUpn'           = @{
			Name     = 'Reset-MsolStrongAuthenticationMethodByUpn'
			MsgError = 'No Graph counterpart known for Reset-MsolStrongAuthenticationMethodByUpn'
		}
		'Restore-MsolUser'                                    = @{
			Name    = 'Restore-MsolUser'
			NewName = 'Restore-MgUser'
		}
		'Set-MsolADFSContext'                                 = @{
			Name     = 'Set-MsolADFSContext'
			MsgError = 'No Graph counterpart known for Set-MsolADFSContext'
		}
		'Set-MsolAdministrativeUnit'                          = @{
			Name    = 'Set-MsolAdministrativeUnit'
			NewName = 'Update-MgDirectoryAdministrativeUnit'
		}
		'Set-MsolCompanyAllowedDataLocation'                  = @{
			Name     = 'Set-MsolCompanyAllowedDataLocation'
			MsgError = 'No Graph counterpart known for Set-MsolCompanyAllowedDataLocation'
		}
		'Set-MsolCompanyContactInformation'                   = @{
			Name    = 'Set-MsolCompanyContactInformation'
			NewName = 'Update-MgOrganization'
		}
		'Set-MsolCompanyMultiNationalEnabled'                 = @{
			Name     = 'Set-MsolCompanyMultiNationalEnabled'
			MsgError = 'No Graph counterpart known for Set-MsolCompanyMultiNationalEnabled'
		}
		'Set-MsolCompanySecurityComplianceContactInformation' = @{
			Name    = 'Set-MsolCompanySecurityComplianceContactInformation'
			NewName = 'Update-MgOrganization'
		}
		'Set-MsolCompanySettings'                             = @{
			Name    = 'Set-MsolCompanySettings'
			NewName = 'Update-MgOrganization'
		}
		'Set-MsolDeviceRegistrationServicePolicy'             = @{
			Name     = 'Set-MsolDeviceRegistrationServicePolicy'
			MsgError = 'No Graph counterpart known for Set-MsolDeviceRegistrationServicePolicy'
		}
		'Set-MsolDirSyncConfiguration'                        = @{
			Name     = 'Set-MsolDirSyncConfiguration'
			MsgError = 'No Graph counterpart known for Set-MsolDirSyncConfiguration'
		}
		'Set-MsolDirSyncEnabled'                              = @{
			Name     = 'Set-MsolDirSyncEnabled'
			MsgError = 'No Graph counterpart known for Set-MsolDirSyncEnabled'
		}
		'Set-MsolDirSyncFeature'                              = @{
			Name     = 'Set-MsolDirSyncFeature'
			MsgError = 'No Graph counterpart known for Set-MsolDirSyncFeature'
		}
		'Set-MsolDomain'                                      = @{
			Name    = 'Set-MsolDomain'
			NewName = 'Update-MgDomain'
		}
		'Set-MsolDomainAuthentication'                        = @{
			Name     = 'Set-MsolDomainAuthentication'
			MsgError = 'No Graph counterpart known for Set-MsolDomainAuthentication'
		}
		'Set-MsolDomainFederationSettings'                    = @{
			Name     = 'Set-MsolDomainFederationSettings'
			MsgError = 'No Graph counterpart known for Set-MsolDomainFederationSettings'
		}
		'Set-MsolGroup'                                       = @{
			Name    = 'Set-MsolGroup'
			NewName = 'Update-MgGroup'
		}
		'Set-MsolPartnerInformation'                          = @{
			Name     = 'Set-MsolPartnerInformation'
			MsgError = 'No Graph counterpart known for Set-MsolPartnerInformation'
		}
		'Set-MsolPasswordPolicy'                              = @{
			Name     = 'Set-MsolPasswordPolicy'
			MsgError = 'No Graph counterpart known for Set-MsolPasswordPolicy'
		}
		'Set-MsolServicePrincipal'                            = @{
			Name    = 'Set-MsolServicePrincipal'
			NewName = 'Update-MgServicePrincipal'
		}
		'Set-MsolUser'                                        = @{
			Name    = 'Set-MsolUser'
			NewName = 'Update-MgUser'
		}
		'Set-MsolUserLicense'                                 = @{
			Name    = 'Set-MsolUserLicense'
			NewName = 'Set-MgUserLicense'
		}
		'Set-MsolUserPassword'                                = @{
			Name    = 'Set-MsolUserPassword'
			NewName = 'Reset-MgUserAuthenticationMethodPassword'
		}
		'Set-MsolUserPrincipalName'                           = @{
			Name    = 'Set-MsolUserPrincipalName'
			NewName = 'Update-MgUser'
		}
		'Update-MsolFederatedDomain'                          = @{
			Name     = 'Update-MsolFederatedDomain'
			MsgError = 'No Graph counterpart known for Update-MsolFederatedDomain'
		}
	}
}