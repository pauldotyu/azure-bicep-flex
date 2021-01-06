# Building Azure Resource Manager templates using Bicep and testing with Pester

This project requires Azure PowerShell. In order to execute against the correct Azure environment ensure you are logged in using the `Connect-AzAccount` command.

## Azure PowerShell

### Installation documentation: https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-5.2.0

After installing Azure PowerShell, login using the `Connect-AzAccount` command.

## Azure Bicep

### Installation documentation: https://github.com/Azure/bicep/blob/main/docs/installing.md

### To build ARM templates, run the following:

```powershell
bicep build {{ your_bicep_file }}
```

A json file will be transpiled and placed in the same directory with the same name as the bicep file

## Pester

Pester comes built-in to the Windows platform. Here, we'll remove the built-in version and install the latest (v5).

### Installation documentation: https://pester.dev/docs/introduction/installation

```powershell
# Run this as administrator

$module = "C:\Program Files\WindowsPowerShell\Modules\Pester"
takeown /F $module /A /R
icacls $module /reset
icacls $module /grant "*S-1-5-32-544:F" /inheritance:d /T
Remove-Item -Path $module -Recurse -Force -Confirm:$false
Install-Module -Name Pester -Force

# To update
Update-Module -Name Pester
```

### To run tests using Pester, run the following from the root directory:

```powershell
Invoke-Pester -Output Detailed
```