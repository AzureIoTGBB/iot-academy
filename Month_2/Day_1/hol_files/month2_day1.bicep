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
    environment: 'demo'
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
