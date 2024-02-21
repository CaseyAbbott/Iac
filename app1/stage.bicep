param location string = resourceGroup().location

module appServiceDeploy '../Templates/appserviceplan.bicep' = {
  name: 'appServiceDeploy'
  params: {
    location: location 
  }
}
