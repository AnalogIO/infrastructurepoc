param location string

@allowed([ 'dev', 'prod' ])
param environment string
param applicationPrefix string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'log-${applicationPrefix}-${environment}'
  location: location
  properties: {
    features: {
      immediatePurgeDataOn30Days: true
    }
    retentionInDays: 31
    sku: {
      name: 'PerGB2018' //Pay-As-You-Go
    }
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-${applicationPrefix}-${environment}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 31
    ImmediatePurgeDataOn30Days: true
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}
