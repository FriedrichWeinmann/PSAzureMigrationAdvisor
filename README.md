# PSAzureMigrationAdvisor

Welcome to the migration toolkit designed to help you migrate your azure-related PowerShell script code.
The sad fact is, it is getting harder and harder to keep track of changes, of what you need to do to keep your code running - especially when all this scripting is not really your main task and you cannot fully devote the time for it.

This is where this project tries to step up and help you.
This is not a magic tool that will wave away all of your problems, but it should help you at least get started and where to look.

## Scope

Currently in scope for this tool:

> Migrating from AzureAD to Microsoft.Graph

The old AzureAD module and its associated API are being retired, the new way to do things is in the Graph API.
This toolkit will help you search your scripts for code that needs to be migrated and helps you get started getting there.

> Migrating from Msonline to Migrosoft.Graph

The old Msonline module and its associated API are being retired, the new way to do things is in the Graph API.
This toolkit will help you search your scripts for code that needs to be migrated and helps you get started getting there.

## Installing

To start using this module, you need to install it from the PowerShell Gallery:

```powershell
Install-Module PSAzureMigrationAdvisor -Scope CurrentUser
```

## Getting Started

> AzureAD --> Microsoft.Graph | Msonline --> Microsoft.Graph

```powershell
# Scan for both AzureAD or Msonline commands
Get-ChildItem C:\scripts -Recurse | Read-AzScriptFile

# Scan for AzureAD commands only
Get-ChildItem C:\scripts -Recurse | Read-AzScriptFile -Type AzureAD

# Scan for Msonline commands only
Get-ChildItem C:\scripts -Recurse | Read-AzScriptFile -Type Msonline
```

Note, the information displayed is formatted for readability, some information is hidden by default.
To get the full information, it is probably easiest to export the data to CSV and check it out in excel:

```powershell
Get-ChildItem C:\scripts -Recurse | Read-AzScriptFile | Export-Csv .\scriptreport.csv
```
