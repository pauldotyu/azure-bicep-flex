param location string
param name_prefix string
param allow_blob_public_access bool
param tags object

var name = '${name_prefix}${uniqueString('zzz')}'

resource st 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: tags
  properties:{
    allowBlobPublicAccess: allow_blob_public_access
  }  
}