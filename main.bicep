resource py 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  location: 'westus2'
  name: 'rg-test'
  tags: {
    key1: 'value1'
  }
}