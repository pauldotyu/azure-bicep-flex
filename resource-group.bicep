param name string
param location string
param tags object

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  location: location
  name: name
  tags: tags
}

output rg_id string = rg.id
output rg_name string = rg.name
output rg_location string = rg.location