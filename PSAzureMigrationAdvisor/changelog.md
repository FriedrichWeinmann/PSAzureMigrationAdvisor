# Changelog

## 1.2.14 (2023-04-13)

+ Upd: Configuration PSAzureMigrationAdvisor.Export.CsvDelimiter - new default value ","

## 1.2.13 (2023-04-13)

+ Upd: Export-AzScriptReport - now has the ability to write the converted files to disk.
+ Upd: Read-AzScriptFile - now returns the ScriptFile object from Refactor to give the user access to the underlying content on which the findings are based.

## 1.2.11 (2023-04-12)

+ Major: Reworked the way mapping data was provided, including the latest mapping data from https://github.com/microsoft/AzureAD-to-MSGraph
+ New: Command Update-AzADMapping - Updates Azure AD to Microsoft Graph API command mapping data.
+ Upd: Export-AzScriptReport - Added scopes, Examples and mapping urls

## 1.1.8 (2022-06-15)

+ New: Command Export-AzScriptReport - Provides improved reporting of results
+ Upd: Convert-AzScriptFile - added `-OutPath` parameter to support writing converted files to a different path, rather than overwriting the originals
+ Fix: Read-AzScriptFile - now accepts empty file-content.

## 1.1.5 (2022-04-14)

+ Upd: Read-AzScriptFile - added support to provide name and text content, instead of path to file
+ Upd: Read-AzScriptFile - added support for .psf1 files
+ Upd: Read-AzScriptFile - added file hash to the output object
+ Upd: Convert-AzScriptFile - added support for .psf1 files

## 1.0.2 (2022-03-14)

+ Read-AZScriptFile - Improved message handling

## 1.0.1 (2022-03-13)

+ Fixed dependencies

## 1.0.0 (2022-03-13)

+ Initial Release
