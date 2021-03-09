Describe "Azure Platform Tests" {
  Context "Azure Resource Group creation in West US 2 without tags" {
    BeforeAll {
      $rgTemplateFile=".\resource-group.json"
      $rgName="rg-pester"
      $rgLocation="westus2"
      $rgTemplateParameters = @{
        name = $rgName
        location = $rgLocation
        tags = @{}
      }

      try {
        $output = New-AzDeployment -WhatIf -Location $rgLocation -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters -ErrorAction Stop
        $msg = $output.ProvisioningState
      }
      catch {
      }
    }

    It "Resource Group deployment should not succeed" {      
      $msg | Should -BeNullOrEmpty
    }
  }

  Context "Azure Resource Group creation in West US 2 without ALL tags" {
    BeforeAll {
      $rgTemplateFile=".\resource-group.json"
      $rgName="rg-pester"
      $rgLocation="westus2"
      $rgTemplateParameters = @{
        name = $rgName
        location = $rgLocation
        tags = @{
          "environment" = "dev"
        }
      }

      try {
        $output = New-AzDeployment -WhatIf -Location $rgLocation -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters -ErrorAction Stop
        $msg = $output.ProvisioningState
      }
      catch {
      }
    }

    It "Resource Group deployment should not succeed" {      
      $msg | Should -BeNullOrEmpty
    }
  }

  Context "Azure Resource Group creation in West US 2 with invalid value for protection-level tag" {
    BeforeAll {
      $rgTemplateFile=".\resource-group.json"
      $rgName="rg-pester"
      $rgLocation="westus2"
      $rgTemplateParameters = @{
        name = $rgName
        location = $rgLocation
        tags = @{
          "po-number" = "zzz"
          "environment" = "dev"
          "mission" = "research"
          "availability-level" = "a1"
          "protection-level" = "zzz"
        }
      }

      try {
        $output = New-AzDeployment -WhatIf -Location $rgLocation -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters -ErrorAction Stop
        $msg = $output.ProvisioningState
      }
      catch {
      }
    }

    It "Resource Group deployment should not succeed" {     
      $msg | Should -BeNullOrEmpty
    }
  }

  Context "Azure Resource Group creation in West US 2 with tags" {
    BeforeAll {
      $rgTemplateFile=".\resource-group.json"
      $rgName="rg-pester"
      $rgLocation="westus2"
      $rgTemplateParameters = @{
        name = $rgName
        location = $rgLocation
        tags = @{
          "po-number" = "zzz"
          "environment" = "dev"
          "mission" = "research"
          "availability-level" = "a1"
          "protection-level" = "p1"
        }
      }

      $output = New-AzDeployment -Location $rgLocation -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters -ErrorAction Stop
    }

    AfterAll {
      Get-AzResourceGroup -Name $rgName | Remove-AzResourceGroup -Force
    }

    It "Resource Group deployment should succeed" {
      $output.ProvisioningState | Should -Be 'Succeeded'
    }
  }

  Context "Azure Resource Group creation in East US 2" {
    BeforeAll {
      $rgTemplateFile=".\resource-group.json"
      $rgName="rg-pester"
      $rgLocation="eastus2"
      $rgTemplateParameters = @{
        name = $rgName
        location = $rgLocation
        tags = @{
          "po-number" = "zzz"
          "environment" = "dev"
          "mission" = "research"
          "availability-level" = "a1"
          "protection-level" = "p1"
        }
      }

      try {
        $output = New-AzDeployment -WhatIf -Location $rgLocation -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters -ErrorAction Stop
        $msg = $output.ProvisioningState
      }
      catch {
      }
    }

    It "Resource Group deployment should not succeed" {
      $msg | Should -BeNullOrEmpty
    }
  }

  Context "Azure storage account creation with public blob access" {
    BeforeAll {
      $rgTemplateFile=".\storage-account.json"
      $rgName="rg-pester"
      $rgLocation="westus2"
      $saNamePrefix="sapester"
      $saAllowBlobPublicAccess=$true
      $tags = @{
        "po-number" = "zzz"
        "environment" = "dev"
        "mission" = "research"
        "availability-level" = "a1"
        "protection-level" = "p1"
      }
      $rgTemplateParameters = @{
        location = $rgLocation
        name_prefix = $saNamePrefix
        allow_blob_public_access = $saAllowBlobPublicAccess
        tags = $tags
      }
      
      New-AzResourceGroup -Name $rgName -Location $rgLocation -Tag $tags

      try {
        $output = New-AzDeployment -WhatIf -Location $rgLocation -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters -ErrorAction Stop
        $msg = $output.ProvisioningState
      }
      catch {
      }
    }

    AfterAll {
      Get-AzResourceGroup -Name $rgName | Remove-AzResourceGroup -Force
    }

    It "Storage account deployment should not succeed" {
      $msg | Should -BeNullOrEmpty
    }
  }

  Context "Azure storage account creation without public blob access" {
    BeforeAll {
      $rgTemplateFile=".\storage-account.json"
      $rgName="rg-pester"
      $rgLocation="westus2"
      $saNamePrefix="sapester"
      $saAllowBlobPublicAccess=$false
      $tags = @{
        "po-number" = "zzz"
        "environment" = "dev"
        "mission" = "research"
        "availability-level" = "a1"
        "protection-level" = "p1"
      }
      $rgTemplateParameters = @{
        location = $rgLocation
        name_prefix = $saNamePrefix
        allow_blob_public_access = $saAllowBlobPublicAccess
        tags = $tags
      }

      New-AzResourceGroup -Name $rgName -Location $rgLocation -Tag $tags
      $output = New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile $rgTemplateFile -TemplateParameterObject $rgTemplateParameters -ErrorAction Stop
    }
  
    AfterAll {
      Get-AzResourceGroup -Name $rgName | Remove-AzResourceGroup -Force
    }

    It "Storage account deployment should succeed" {
      $output.ProvisioningState | Should -Be 'Succeeded'
    }
  }
}