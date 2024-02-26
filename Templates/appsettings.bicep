// App settings to link ApplicationInsights to App Service
param appSettings1Name string
param appSettings1Value string
param appSettings2Name string
param appSettings2Value string

resource appServiceAppSetting 'Microsoft.Web/sites/config@2021-01-15' = {
  name: '/web'
  properties: {
    appSettings: [
      {
        name: appSettings1Name
        value: appSettings1Value
      }
      {
        name: appSettings2Name
        value: appSettings2Value
      }
    ]        
  }
}
