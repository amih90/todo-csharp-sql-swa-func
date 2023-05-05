//parameters
@description('Location for all resources.')
param location string
param monitoringGcsEnvironment string
param monitoringGcsAccount string
param monitoringGcsNamespace string
param monitoringGcsAuthId string
param monitoringConfigVersion string
param monitoringTenant string
param serverFarmName string
@secure()
param genevaCertContent string

//variables
var configXml = '<MonitoringManagement eventVersion="1" version="1.0" timestamp="2017-12-29T00:00:00Z" namespace="PlaceHolder"></MonitoringManagement>'
var configJson = {
  MONITORING_TENANT: monitoringTenant
  MONITORING_ROLE: serverFarmName
  MONITORING_XSTORE_ACCOUNTS: 'GCSPlaceholder'
  AdditionalEnvironmentVariables: [
    {
      Key: 'DATACENTER'
      Value: location
    }
    {
      Key: 'MONITORING_GCS_ENVIRONMENT'
      Value: monitoringGcsEnvironment
    }
    {
      Key: 'MONITORING_GCS_ACCOUNT'
      Value: monitoringGcsAccount
    }
    {
      Key: 'MONITORING_GCS_NAMESPACE'
      Value: monitoringGcsNamespace
    }
    {
      Key: 'MONITORING_GCS_REGION'
      Value: location
    }
    {
      Key: 'MONITORING_GCS_AUTH_ID'
      Value: monitoringGcsAuthId
    }
    {
      Key: 'MONITORING_GCS_AUTH_ID_TYPE'
      Value: 'AuthKeyVault'
    }
    {
      Key: 'MONITORING_CONFIG_VERSION'
      Value: monitoringConfigVersion
    }
    {
      Key: 'MONITORING_USE_GENEVA_CONFIG_SERVICE'
      Value: 'true'
    }
  ]
}

//resources
resource AntMDS_ConfigJson 'Microsoft.Web/serverfarms/firstPartyApps/settings@2022-03-01' = {
  name: '${serverFarmName}/AntMDS/ConfigJson'
  location: location
  properties: {
    firstPartyId: 'AntMDS'
    settingName: 'ConfigJson'
    settingValue: string(configJson)
  }
}

resource AntMDS_MdsConfigXml 'Microsoft.Web/serverfarms/firstPartyApps/settings@2022-03-01' = {
  name: '${serverFarmName}/AntMDS/MdsConfigXml'
  location: location
  properties: {
    firstPartyId: 'AntMDS'
    settingName: 'MdsConfigXml'
    settingValue: configXml
  }
}

resource AntMDS_CERTIFICATE_PFX_GENEVACERT 'Microsoft.Web/serverfarms/firstPartyApps/settings@2022-03-01' = {
  name: '${serverFarmName}/AntMDS/CERTIFICATE_PFX_GENEVACERT'
  location: location
  properties: {
    firstPartyId: 'AntMDS'
    settingName: 'CERTIFICATE_PFX_GENEVACERT'
    settingValue: genevaCertContent
  }
}

resource AntMDS_CERTIFICATE_PASSWORD_GENEVACERT 'Microsoft.Web/serverfarms/firstPartyApps/settings@2022-03-01' = {
  name: '${serverFarmName}/AntMDS/CERTIFICATE_PASSWORD_GENEVACERT'
  location: location
  properties: {
    firstPartyId: 'AntMDS'
    settingName: 'CERTIFICATE_PASSWORD_GENEVACERT'
    settingValue: ''
  }
}
