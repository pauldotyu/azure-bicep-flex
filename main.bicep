param name string = 'rg-test'
param location string = 'westus2'
param tags object = {
  key1: 'value1'
  key2: 'value2'
}

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  location: location
  name: name
  tags: tags
}

output rg_id string = rg.id