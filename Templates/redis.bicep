resource redisCache 'Microsoft.Cache/Redis@2019-07-01' = {
  name: 'name'
  location: location
  properties: {
    sku: {
      name: 'Basic'
      family: 'C'
      capacity: 0
    }
  }
}
