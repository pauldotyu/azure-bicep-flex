Describe "Azure Platform Tests" {
  Context "Azure Resource Group creation in WestUS2" {
    BeforeAll {
      $rg_template_file="resource-group.json"
      $rg_location="westus2"
      $rg_name=(-join((65..90) + (97..122) | Get-Random -Count 12 | % { [CHAR]$_ }) | Out-String).ToLower()
    }

    AfterAll {
      az group delete -n $rg_name -y
    }

    It "Resource Group deployment should succeed" {
    
      $output = az deployment sub create --location $rg_location `
        --template-file $rg_template_file `
        --parameters name=$rg_name `
        --parameters location=$rg_location | ConvertFrom-Json
  
      $output.properties.ProvisioningState | Should -Be 'Succeeded'
    }
  }
}


# Invoke-Pester -Output Detailed