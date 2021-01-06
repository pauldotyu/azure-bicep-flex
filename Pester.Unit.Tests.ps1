Describe "Azure Platform Tests" {
  Context "Azure Resource Group creation in West US 2" {
    BeforeAll {
      $rgTemplateFile=".\resource-group.json"
      $rgName="rg-pester"
      $rgLocation="westus2"
      $rgTemplateParameters = @{
        name = $rgName
        location = $rgLocation
        tags = @{}
      }
    }

    AfterAll {
      Get-AzResourceGroup -Name $rgName | Remove-AzResourceGroup -Force
    }

    It "Resource Group deployment should succeed" {
      $output = New-AzDeployment -WhatIf -Location $rgLocation -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters
      $output.ProvisioningState | Should -Be 'Succeeded'
    }
  }

  Context "Azure Resource Group creation in East US 2" {
    BeforeAll {
      $rgTemplateFile=".\resource-group.json"
      $rgName="rg-pester"
      $rgLocation="eastus22"
      $rgTemplateParameters = @{
        name = $rgName
        location = $rgLocation
        tags = @{}
      }
    }

    try {
      $output = New-AzDeployment -WhatIf -Location $rgLocation -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters
      $msg = $output.ProvisioningState
    }
    catch {
      $ex = $_.Exception | Format-List -Force
      $msg = $ex.Message
    }

    It "Resource Group deployment should not succeed" {
      $msg | Should -Not -Be "Suceeded"
    }
  }

  Context "ContextName" {
    BeforeAll {
      $rgTemplateFile=".\storage-account.json"
      $rgName="rg-pester"
      $rgLocation="eastus22"
      $rgTemplateParameters = @{
        name = $rgName
        location = $rgLocation
        tags = @{}
      }
    }

    It "ItName" {
      Assertion
    }
  }
}