param name string
param location string = resourceGroup().location
param tags object = {}

param principalId string = ''
param enableSoftDelete bool = false
param enabledForDeployment bool = false
param enabledForTemplateDeployment bool = false
param enabledForDiskEncryption bool = false

resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    sku: { family: 'A', name: 'standard' }
    accessPolicies: !empty(principalId) ? [
      {
        objectId: principalId
        permissions: { secrets: [ 'get', 'list' ] }
        tenantId: subscription().tenantId
      }
    ] : []
    enableSoftDelete: enableSoftDelete
    enabledForDeployment: enabledForDeployment
    enabledForTemplateDeployment: enabledForTemplateDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
  }
}

output endpoint string = keyVault.properties.vaultUri
output name string = keyVault.name
