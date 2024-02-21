param location string = resourceGroup().location

// App Sevice Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'asp-d-test'
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

// App Service
resource appService 'Microsoft.Web/sites@2021-01-15' = {
  name: 'app-d-test'
  location: location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', 'asp-d-test')
    siteConfig: {
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      ftpsState: 'Disabled'
      netFrameworkVersion: 'v6.0'
    }
  }
  dependsOn: [
    appServicePlan
  ]
}

// App settings to link ApplicationInsights to App Service
resource appServiceAppSetting 'Microsoft.Web/sites/config@2021-01-15' = {
  name: 'web'
  parent: appService
  properties: {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: appInsightsComponents.properties.InstrumentationKey
      }
      {
        name: 'key2'
        value: 'value2'
      }
    ]        
  }
}

// Application Insights
resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-d-test'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
