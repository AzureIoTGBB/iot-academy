param location string = resourceGroup().location

@description('First Name.')
param first_name string

@description('Last Name.')
param last_name string

@description('Favorite Animal.')
param favorite_animal string

@description('Student Prefix.')
param studentPrefix string = uniqueString(first_name, last_name, favorite_animal, resourceGroup().id)

resource iothub 'Microsoft.Devices/IotHubs@2021-07-02' = {
  name: 'iot-${studentPrefix}'
  location: location
  tags: {
    environment: 'dev'
  }
  sku: {
    name: 'S1'
    capacity: 1
  }
}
resource dps 'Microsoft.Devices/provisioningServices@2020-01-01' = {
  name: 'dps-${studentPrefix}'
  location: location
  sku: {
      name: 'S1'
      capacity: 1
  }
  properties:{
    iotHubs: [
      {
          connectionString: 'HostName=${iothub.name}.azure-devices.net;SharedAccessKeyName=${listKeys(iothub.id, '2020-04-01').value[0].keyName};SharedAccessKey=${listKeys(iothub.id, '2020-04-01').value[0].primaryKey}'
          location: location
      }
  ]  
  }
}

// Basic logic app
resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'logic-${studentPrefix}'
  location: location
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      actions: {}
      contentVersion: '1.0.0.0'
      outputs: {}
      parameters: {}
      triggers: {}
    }
  }
}

resource log 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: 'log-${studentPrefix}'
  location: location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

