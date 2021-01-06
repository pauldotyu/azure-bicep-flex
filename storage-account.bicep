param st_location string
param st_name_prefix string
param st_tags object

var rg_name = 'rg-${st_name_prefix}'

module rg 'resource-group.bicep' = {
  name: 'moduledeploy'
  params: {
    location: st_location
    name: rg_name
    tags: st_tags
  }
}

var st_name = '${st_name_prefix}${uniqueString(rg.outputs.rg_id)}'

resource st 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: st_name
  location: st_location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: st_tags
}