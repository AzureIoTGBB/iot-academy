# 1. Azure IoT Academy Month Two, Day Two, Lab Two
## Click Below Link to Watch Lab Two Video (placeholder)
## 1.1. [Day Two: Hands on Lab Two Video placeholder](placeholder)

This hands on lab seeks to introduce the student to the following Azure Services and Technologies:

- Visual Studio
- Azure Digital Twins
- Azure Cloud Shell

This Azure Digital Twins lab describes how to build out an end-to-end solution that demonstrates the functionality of the service. To set up a full end-to-end solution driven by live data from your environment, you can connect your Azure Digital Twins instance to other Azure services for management of devices and data.

In this tutorial, you will...

 * Set up an Azure Digital Twins instance
 * Learn about the sample building scenario and instantiate the pre-written components
 * Use an [Azure Functions](../azure-functions/functions-overview.md) app to route simulated telemetry from an [IoT Hub](../iot-hub/about-iot-hub.md) device into digital twin properties
 * Propagate changes through the twin graph by processing digital twin notifications with Azure Functions, endpoints, and routes

 Course Content

- [1. Azure IoT Academy Month Two Day Two Lab Two](#1-azure-iot-academy-month-two-day-two-lab-two)
  - [1.1. Day Two: Hands on Lab Two Video](#11-Day-Two-Hands-on-Lab-Three-Video)
  - [1.2. Prerequisites](#12-prerequisites)
    - [1.2.1. Install VS Code](#121-install-vs-code)
    - [1.2.2. Download ZIP of Azure Digital Twins sample C# project](#122-Download-ZIP-of-Azure-Digital-Twins-sample-C#-project)
    - [1.2.3. Prepare an Azure Digital Twins instance](#123-Prepare-an-Azure-Digital-Twins-instance)
    - [1.2.4. Prepare your environment for the Azure CLI](#124-Prepare-your-environment-for-the-Azure-CLI)
    - [1.2.5. Set up CLI session](#125-Set-up-CLI-session)
  - [1.3. Exercise: Configure the ADT sample project](#13-Configure-the-ADT-sample-project)
    - [1.3.1. Get started with the building scenario](#131-Get-started-with-the-building-scenario)
    - [1.3.2. Instantiate the pre-created twin graph](#132-Instantiate-the-pre-created-twin-graph)
    - [1.3.3. Set up the sample function app](#133-Set-up-the-sample-function-app)
    - [1.3.4. Update dependencies](#134-Update-dependencies)
    - [1.3.5. Publish the app](#135-Publish-the-app)
    - [1.3.6. Configure permissions for the function app](#136-Configure-permissions-for-the-function-app)
    - [1.3.7. Assign access role](#137-Assign-access-role)
    - [1.3.8. Configure application settings](#138-Configure-application-settings)
  - [1.4. Excercise: Process simulated telemetry from an IoT Hub device](#14-Process-simulated-telemetry-from-an-IoT-Hub-device)
    - [1.4.1. Connect the IoT hub to the Azure function](#141-Connect-the-IoT-hub-to-the-Azure-function)
    - [1.4.2. Register the simulated device with IoT Hub](#142-Register-the-simulated-device-with-IoT-Hub)
    - [1.4.3. Configure and run the simulation](#143-Configure-and-run-the-simulation)
    - [1.4.4. See the results in Azure Digital Twins](#144-See-the-results-in-Azure-Digital-Twins)
  - [1.5. Exercise: Propagate Azure Digital Twins events through the graph](#15-Propagate-Azure-Digital-Twins-events-through-the-graph)
    - [1.5.1. Create the Event Grid topic](#151-Create-the-Event-Grid-topic)
    - [1.5.2. Create the endpoint](#152-Create-the-endpoint)
    - [1.5.3. Create the route](#153-Create-the-route)
    - [1.5.4. Connect the Azure function](#154-Connect-the-Azure-function)
  - [1.6. Exercise: Run the simulation and see the results](#16-Run-the-simulation-and-see-the-results)
    - [1.6.1. Review](#161-Review)
    - [1.6.2. Clean up Resources](#162-Clean-up-resources)
    - [1.6.3. Next Steps](#163-next-steps)

## 1.1. Placeholder

### 1.1.1. Placeholder
[Visual Studio Download](https://visualstudio.microsoft.com/vs/)
* For Mac users the latest version of Visual Studio 2022 for Mac (version 17.2) offers the most development features

### 1.1.2. Placeholder


### 1.5.1. Review

Here's a review of the scenario that you built out in this tutorial.


![](./media/tutorial-end-to-end/building-scenario.png 'Diagram of the full building scenario, which shows the data flowing from a device into and out of Azure Digital Twins through various Azure services')

### 1.5.2. Clean up resources

After completing this tutorial, please move on to Lab Two


### 1.5.3. Next steps

In this tutorial, you created an end-to-end scenario that shows Azure Digital Twins being driven by live device data.

Next, start looking at the [concept documentation](https://docs.microsoft.com/en-us/azure/digital-twins/concepts-models) to learn more about elements you worked with in the tutorial:
