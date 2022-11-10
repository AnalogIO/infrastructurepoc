param location string

@allowed([ 'dev', 'prd' ])
param environment string

param organizationPrefix string
param applicationPrefix string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'log-${organizationPrefix}-${applicationPrefix}-${environment}'
  location: location
  properties: {
    features: {
      immediatePurgeDataOn30Days: true
    }
    retentionInDays: 30
    sku: {
      name: 'PerGB2018' //Pay-As-You-Go
    }
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-${organizationPrefix}-${applicationPrefix}-${environment}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 30
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}
