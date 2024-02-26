param location string = resourceGroup().location
var resourceGroupName = resourceGroup().name

// App Service
param appServiceName string = 'web'

// App settings for app service
param appSettings1Name string = 'APPINSIGHTS_INSTRUMENTATIONKEY'
param appSettings1Value string = instrumentationKey //.instrumentationKey
param appSettings2Name string = 'TEST'
param appSettings2Value string = 'testing'

// App Insights
param appInsightsName string = 'insights' 

// App settings
var instrumentationKey = 'az monitor app-insights component show --resource-group " + resourceGroupName + " --name appInsightsName --query properties.InstrumentationKey --output tsv'


module appServicePlan '../Templates/appserviceplan.bicep' = {
  name: 'appServiceDeploy'
  params: {
    location: location 
  }
}

module appService '../Templates/appservice.bicep' = {
  name: appServiceName
  params:{
    location: location
    
  }
  dependsOn: [
    appServicePlan
  ]
}

module appInsightsComponents '../Templates/appinsights.bicep' = {
  name: appInsightsName
  params: {
    location: location
  }
}

output appInsightsInstrumentationKey string = appInsightsComponents.outputs.appInsightsInstrumentationKey
