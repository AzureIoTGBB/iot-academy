# 1. Azure IoT Academy Month Two Day One

This hands on lab seeks to introduce the student to the following Azure Services and Technologies:
   - Visual Studio Code
   - Azure IoT Hub
   - Azure Device Provisioning Service (DPS)
   - Azure Virtual Machines
   - Azure Edge for Linux on Windows (EFLOW)
   - Azure IoT Edge Routing
   - Azure IoT Edge Stream Analytics (ASA) Module
   - Azure Logic Apps
   - Azure Monitor & Azure Log Analytics
   
These services are explored as they're often part of overall IoT solutions. A simplistic approach is taken with this lab to allow to reach many audiences of varying technical experience.

Ideally students taking this course will have:
   - familiarity with the Azure Portal. [https://portal.azure.com](https://portal.azure.com/)
   - Completed IoT Academy Month One Content

A good way to become familiar with Azure IoT is to follow Azure IoT Developer Specialty certification path. You can read more at the following link: [https://docs.microsoft.com/en-us/learn/certifications/exams/az-220](https://docs.microsoft.com/en-us/learn/certifications/exams/az-220)

Course Content

- [1. Azure IoT Academy Month Two Day One](#1-azure-iot-academy-month-two-day-one)
  - [1.1. Prerequisites](#11-prerequisites)
    - [1.1.1. Install VS Code](#111-install-vs-code)
    - [1.1.2. Install VS Code Extensions](#112-install-vs-code-extensions)
    - [1.1.3. Install Azure CLI](#113-install-azure-cli)
    - [1.1.4. Install Azure CLI Bicep Extension](#114-install-azure-cli-bicep-extension)
    - [1.1.5. Supporting Materials](#115-supporting-materials)
  - [1.2. Exercise: Deploy Azure IoT Hub and DPS with Bicep](#12-exercise-deploy-azure-iot-hub-and-dps-with-bicep)
    - [1.2.1. Supporting Materials](#121-supporting-materials)
    - [1.2.2. Review the Bicep file](#122-review-the-bicep-file)
    - [1.2.2. Use the Bicep visualizer to review the resources](#122-use-the-bicep-visualizer-to-review-the-resources)
    - [1.2.3. Edit your bicep parameters file](#123-edit-your-bicep-parameters-file)
    - [Ensure you've selected your subscription and correct tenant](#ensure-youve-selected-your-subscription-and-correct-tenant)
    - [Create an Azure Resource Group](#create-an-azure-resource-group)
    - [1.2.3. Create an Azure Resource Manager Deployment](#123-create-an-azure-resource-manager-deployment)

## 1.1. Prerequisites

### 1.1.1. Install VS Code
[Visual Studio Code Download](https://code.visualstudio.com/Download)

### 1.1.2. Install VS Code Extensions
   1. Click extensions
   2. Search for `azure iot`
   3. Click install for the `Azure IoT Tools` extension pack

### 1.1.3. Install Azure CLI
   - [https://docs.microsoft.com/en-us/cli/azure/install-azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

### 1.1.4. Install Azure CLI Bicep Extension

### 1.1.5. Please ensure you cloned the IoT Academy Repo locally to your machine

### 1.1.6. Supporting Materials
   - [https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)  

   Open your terminal in VS Code and run the following commands
   Terminal -> New Terminal if not open yet

   ```
   az bicep install
   az bicep upgrade
   az bicep version
   ```

## 1.2. Exercise: Deploy Azure IoT Hub and DPS with Bicep
### 1.2.1. Supporting Materials
[https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep)  

### 1.2.2. Review the Bicep file
[https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameters](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameters)

1. Within the github repo: (https://github.com/AzureIoTGBB/iot-academy-april-2022-internal/tree/main/Month_2/Day_1/hol_files) 
2. Locate the file at the following location and review the contents.`Month_2/Day_1/hol_files_new/month2_day1.bicep`
   
You'll see in the file:
- two resources
- two accepted parameters for iot_hub_name and location

![](./media/bicep_file.png)

### 1.2.2. Use the Bicep visualizer to review the resources
1. Within VS Code trigger the command pallette Ctrl+Shift+P, or click View, command pallette from the menu.
2. Type `visual` and select the `Bicep: Open Bicep Visualizer to the Side` entry, press enter.
3. Select your Bicep file from the HOL and transfer to your VS code, visualize and review the diagram as seen below
   ![](./media/bicep_visualizer.png)

### 1.2.3. Edit your bicep parameters file 

1. Look for the `Month_2/Day_1/hol_files_new/month2_day1_params.json` file and open it
2. Edit the following values:
   1. vm_size: you may need to find an available size in your selected location. This could be done by using the Azure Portal to create a VM and cancelling the process before **Review and Create**
   2. first_name
   3. last_name
   4. favorite_animal: this could be any random string value. This is used in the Bicep template to ensure unique resource names are achieved
   5. vm_admin_password: change the value to your preference or leave default. 
   6. client_ipaddress: as in Month 1. Use bing and search for `what is my ip`, replace with the found value

### Ensure you've selected your subscription and correct tenant
1. Run the following command to ensure your subscription is currently default
    ```
    az account show -o table
    ```

2. If the correct subscription is selected skip this step
   1. If your subscription is listed but not default run this step
    ```
    az account set -s "YourSubscriptionIdGoesHere"
    ```
   2. If your subscription is not listed you've logged into the wrong tenant. Run the following command to login to the correct tenant. After you complete this step run the prior two steps again to list and set your subscription to default.
    ```
    az login -o table
    ```


### Create an Azure Resource Group

In your terminal run the following command. Ensure you replace the location with the correct value.
After the command is run `"provisioningState": "Succeeded"` can be observed in the result

```
az group create --name rg-iotacademy --location northcentralus
```

### 1.2.3. Create an Azure Resource Manager Deployment

[https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/)

1. Run the following command in your terminal in VS Code
```
az deployment group create --resource-group rg-iotacademy --template-file month2_day1.bicep --parameters month2_day1_params.json
```

2. Go to the Azure Portal, find an open the `rg-iotacademy` resource group. 
3. Click Deployments, and click the first your deployment in the list. Review the following screenshots for what to expect
![](./media/bicep_deployment_list.png)
![](./media/bicep_deployment_running.png)
![](./media/bicep_deployment_complete.png)


