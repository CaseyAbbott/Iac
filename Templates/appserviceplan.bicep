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
