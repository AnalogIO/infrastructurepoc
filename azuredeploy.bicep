param location string = resourceGroup().location

@allowed([ 'dev', 'prod' ])
param environment string
param applicationPrefix string = 'ioweb'

resource appservicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'plan-${applicationPrefix}-${environment}'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    family: 'B'
    size: 'B1'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    perSiteScaling: true
    reserved: true
  }
}

module insightsModule 'modules/insights.bicep' = {
  name: '${deployment().name}-insights'
  params: {
    location: location
    environment: environment
    applicationPrefix: applicationPrefix
  }
}
