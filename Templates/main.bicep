param location string = resourceGroup().location



// App Sevice Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'asp-d-test'
  location: location
  kind: 'windows'
  sku: {
    name: 'F1'
    capacity: 1
  }
}

// App Service
resource appService 'Microsoft.Web/sites@2021-01-15' = {
  name: 'app-d-test'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    httpsOnly: true
    serverFarmId: resourceId('Microsoft.Web/serverfarms', 'asp-d-test')
    siteConfig: {
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      ftpsState: 'Disabled'
      netFrameworkVersion: 'v6.0'
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsComponents.properties.InstrumentationKey
        }
        {
          name: 'KEY_VAULT_URL'
          value: keyVault.properties.vaultUri
        }
        {
          name: 'key3'
          value: 'value3'
        }
      ]        
    }
    }
    dependsOn: [
      appServicePlan
    ]
  }

// App settings to link ApplicationInsights to App Service
//resource appServiceAppSetting 'Microsoft.Web/sites/config@2021-01-15' = {
//  name: 'web'
//  parent: appService
//  properties: {
//    appSettings: [
//      {
//        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
//        value: appInsightsComponents.properties.InstrumentationKey
//      }
//      {
//        name: 'key2'
//        value: 'value2'
//      }
//    ]        
//  }
//}

// Application Insights
resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-d-test'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'kv-d-test'
  location: location
  properties: {
    enableRbacAuthorization: true
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: subscription().tenantId
//    accessPolicies: [
//      {
//        tenantId: subscription().tenantId
//        objectId: 'objectId'
//        permissions: {
//          keys: [
//            'get'
//          ]
//          secrets: [
//            'list'
//            'get'
//          ]
//        }
//      }
//    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}
