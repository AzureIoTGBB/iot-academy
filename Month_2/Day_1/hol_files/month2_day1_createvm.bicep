@description('First Name.')
param first_name string

@description('Last Name.')
param last_name string

@description('Favorite Animal.')
param favorite_animal string

@description('Student Prefix.')
param studentPrefix string = uniqueString(first_name, last_name, favorite_animal, resourceGroup().id)

@description('Username for the Virtual Machine.')
param vm_admin_username string

@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param vm_admin_password string

@description('Name of the virtual machine.')
param vm_name string = toLower('vm-${studentPrefix}-eflow')

@description('Your client IP address. Use Bing and search for "what is my ip".')
param client_ipaddress string

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsLabelPrefix string = toLower('eflow${studentPrefix}')

@description('Name for the Public IP used to access the Virtual Machine.')
param publicIpName string = toLower('pip-${studentPrefix}eflow')

@description('Allocation method for the Public IP used to access the Virtual Machine.')
@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string = 'Dynamic'

@description('SKU for the Public IP used to access the Virtual Machine.')
@allowed([
  'Basic'
  'Standard'
])
param publicIpSku string = 'Basic'

@description('The Windows version for the VM. This will pick a fully patched Gen2 image of this given Windows version.')
@ allowed([
 'win10-21h2-pro-g2'
])
param vm_os_version string = 'win10-21h2-pro-g2'

@description('Size of the virtual machine. Standard_B2ms, DS1_v2, D2s_v5')
param vm_size string

@description('Location for all resources.')
param location string = resourceGroup().location

var student_prefix_short = substring(studentPrefix, 0, 6)
var storageAccountName = 'st${student_prefix_short}eflowbootdiag'
var nicName = 'nic-${studentPrefix}-eflow'
var addressPrefix = '10.0.0.0/16'
var subnetName = 'Subnet'
var subnetPrefix = '10.0.0.0/24'
var virtualNetworkName = 'vnet-${studentPrefix}-eflow'
var networkSecurityGroupName = 'nsg-${studentPrefix}-eflow'
var vm_computer_name = 'eflow-${student_prefix_short}'



resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

resource pip 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: publicIpName
  location: location
  sku: {
    name: publicIpSku
  }
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
  }
}

resource securityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'allow-3389-clientip'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: client_ipaddress
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          networkSecurityGroup: {
            id: securityGroup.id
          }
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetName)
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vm_name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vm_size
    }
    osProfile: {
      computerName: vm_computer_name
      adminUsername: vm_admin_username
      adminPassword: vm_admin_password
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'Windows-10'
        sku: vm_os_version
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      dataDisks: [
        {
          diskSizeGB: 1023
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: stg.properties.primaryEndpoints.blob
      }
    }
  }
}

output hostname string = pip.properties.dnsSettings.fqdn
