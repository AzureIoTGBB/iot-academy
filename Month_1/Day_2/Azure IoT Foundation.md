# Internet of Things

1) Azure IoT Foundation, theory

2) Getting familiar with Azure Portal
https://portal.azure.com/

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [**Exercise 1: IoT Hub provisioning**](#exercise-1-iot-hub-provisioning)
  - [**Task 1: Provision IoT Hub through the Portal**](#task-1-provision-iot-hub-through-the-portal)
  - [**Task 2: Provision IoT Hub through CLI**](#task-2-provision-iot-hub-through-cli)
  - [**Task 3: Provision IoT Hub through VS Code**](#task-3-provision-iot-hub-through-vs-code)
- [**Exercise 2: Devices**](#exercise-2-devices)
  - [**Task 1: Adding an Azure IoT Edge Device to IoT Hub**](#task-1-adding-an-azure-iot-edge-device-to-iot-hub)
  - [**Task 2: Creating a VM to host an IoT Edge Device**](#task-2-creating-a-vm-to-host-an-iot-edge-device)
  - [**Task 3: Connecting to your Ubuntu Virtual Machine**](#task-3-connecting-to-your-ubuntu-virtual-machine)
  - [**Task 4: Install the Azure IoT Edge Runtime**](#task-4-install-the-azure-iot-edge-runtime)

<!-- /code_chunk_output -->


## **Exercise 1: IoT Hub provisioning**

### **Task 1: Provision IoT Hub through the Portal**

During this exercise you will use 3 different tools to create three different IoT Hubs, after this exercise we will delete two and continue the rest of the workshop with the first IoT Hub created through the Portal.

1. In your browser, navigate to the [Azure portal](https://portal.azure.com), select **+Create a resource** in the navigation pane, enter `iot` into the **Search the Marketplace** box.

   ![+Create a resource is shown on the Azure Portal home page.](./media/create-resource.png 'Create a resource')

2. Select **IoT Hub** from the results

   ![+Create a resource is highlighted in the navigation page of the Azure portal, and "iot" is entered into the Search the Marketplace box. IoT Hub is highlighted in the search results.](./media/create-resource-iot-hub.png 'Create an IoT Hub')

3. Select **Create**.   

   ![+The create button is now shown.](./media/create-resource-iot-hub-button.png 'Create button')

4. On the **IoT Hub** blade **Basics** tab, enter the following:

   - **Subscription**: Select the subscription you are using for this hands-on lab.

   - **Resource group**: Click Create new underneath Resource group. Enter the name `rg-iot-academy`

   <pre>

   </pre>

     ![After clicking create new under resource group enter your new resource group name.](./media/iot-hub-basics-blade-create-resource-group.png 'Create IoT Hub New Resource Group')

   - **Region**: Select the location you are using for this hands-on lab.

   - **IoT Hub Name**: Enter a unique name, such as `iot-academy-johndoe-220427`. 
   The name follows best practices for naming resources in Azure.
   Note: 
      1. the prefix `iot-`
      2. the inclusion of a name 'johndoe' and a date `220427(YYMMDD)` this combination such as `johndoe-220427` will be known as your **suffix**. You may want to copy this to your notepad so you can copy and paste it later.

      As some resources in Azure require unique names, the name and the date helps to avoid naming conflicts.
      More can be read concerning best practices for naming Azure resources at the following link: [Azure Naming and Tagging](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
      For common resource prefixes refer to the following link: [Azure Resource Abbreviations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)

     ![The Basics blade for IoT Hub is displayed, with the values specified above entered into the appropriate fields.](./media/iot-hub-basics-blade.png 'Create IoT Hub Basic blade')

   - Click **Next: Networking**.

   - On the **Networking** tab ensure Public is selected

   - Click **Next: Management**.

   - On the **Management** tab
      1. **Pricing and scale tier**: ensure **S1: Standard tier** is selected
      2. **Number of S1 IoT hub units**: ensure **1** is selected
      3. **Defender for IoT**: set to **On**
      4. **Assign me to the IoT Hub Data Contributor role**: select the check box
      5. **Device-to-cloud partitions**: leave the default setting of **4**

   - Click **Review + create**.

   - Ensure validation passes and click **Create**.

5. After clicking create you were directed to a deployment overview page. When the deployment completes click the **Go to resource** button.

   ![Screenshot of the deployment overview.](./media/iot-hub-create-complete.png 'Deployment succeeded message')

### **Task 2: Provision IoT Hub through CLI**

1. Open cloud with the below link

    https://shell.azure.com/

   If you've never used the Azure Cloud Shell before you will be prompted to mount a storage account, click **Create Storage** to continue. If you used Azure Cloud Shell before, you will skip this step.

   ![Mount Storage Account.](./media/mount-storage.png 'Mount Storage Account')

2. Change to **Bash** access

   ![Screenshot of Bash access.](./media/bash.png 'Access Bash Link')

3. Once you are login run the following command to create an IoT Hub.

   In the following command replace **iot-johndoe-cli-220427** with your iothub name, replacing johndoe and the appropriate date, of the form iot-{yourname}-cli-{YYMMDD}

   ```bash  
   az iot hub create --name iot-academy-johndoe-cli-220427 --resource-group rg-iot-academy --sku S1
   ```

   As the command runs you'll observe the following result.

   ![Screenshot of IoT Hub create running.](./media/iot-hub-create-cli-running.png 'IoT Hub create running')

   When the command completes you'll see output as follows
   
   ![Screenshot of IoT Hub create complete.](./media/iot-hub-create-cli-complete.png 'IoT Hub create complete')


4. Browse to the [Azure Portal](https://portal.azure.com) to verify your newly created IoT Hub. 

5. Delete the IoT Hub just created using the delete command.

   Again, replace johndoe and the appropriate date
   ```bash 
   az iot hub delete --name iot-johndoe-cli-220427 --resource-group rg-iot-academy
   ```

### **Task 3: Provision IoT Hub through VS Code**

If you have not yet installed Visual Studio Code download and install from the following link:
   https://code.visualstudio.com/download

Our third way of creating an Azure resource, IoT Hub instance, is to use Visual Studio Code. 

1. Install IoT Tools extension pack for VS Code in one of two ways:
   - Use the following URL
   https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.azure-iot-tools

   - Use the extension tab (highlighted in red) in VS Code, search for **iot tools**, select **Azure IoT Tools**, click **Install**

      ![VS Code Install IoT Tools Extension Pack.](./media/vscode-install-azure-iot-tools.png 'VS Code Install IoT Tools Extension Pack')

2. Click the View Menu and then Explorer

   ![VS Code View Explorer.](./media/vscode-view-explorer.png 'VS Code View Explorer')

   - Now you should be able to see the **Azure IoT Hub**

      ![VS Code IoT Hub.](./media/vscode-view-explorer-iothub.png 'VS Code IoT Hub')

   - To create a new IoT Hub Go to the menu **View** on the top toolbar then select **Command Palette**. 

      ![VS Code Command Palette.](./media/vscode-view-command-palette.png 'VS Code Command Palette')

   - Type **Azure IoT Hub** in the search bar,  then you will see the list of commands available select  **Azure IoT Hub: Create IoT Hub** and click Enter.

      ![VS Code IoT Hub Create.](./media/vscode-command-iothub-create.png 'IoT Hub Create')

   - Select the following parameters:
      - **Subscription**: Select your subscription.
      - **Resource group**: Use existing and select `rg-iot-academy`.
      - **Location**: Select the location you are using for resources in this hands-on lab.
      - **SKU**: Select **S1**.
      - **Name**: Assign a name to the IoTHub `iot-academy-johndoe-vscode-220427` change **johndoe** and **220427** using your name and the date YYMMDD.

      As the extension creates the IoT Hub instance you should see a status message as follows.

      ![VS Code IoT Hub Creating.](./media/vscode-iothub-creating.png 'IoT Hub Creating')

   - After the creation process you should be able to see the new IoT Hub in VS Code and the Azure Portal.

      ![VS Code IoT Hub Created.](./media/vscode-iothub-created.png 'VS Code IoT Hub Created')

      Azure Portal Resource Group View

      ![Azure Portal IoT Hub Created.](./media/vscode-azureportal-iothub-created.png 'Azure Portal IoT Hub Created')

## **Exercise 2: Devices**

During this exercise you will learn how to set up an Azure IoT Edge device and connect it to IoT Hub to start streaming data.

### **Task 1: Adding an Azure IoT Edge Device to IoT Hub**

   - From Azure Portal select the IoT Hub created through VS Code. To do this, you could search for your resource group rg-iot-academy 

  ![Find Resource Group.](./media/add-edge-device-portal-find-resourcegroup.png 'Find Resource Group')
   

   - scroll down to **Device Management**
   - click **IoT Edge**
   - click **Add IoT Edge device**

   ![Create Edge Device.](./media/add-edge-device-portal.png 'Create Edge Device')

   - In the new window enter a name for your device **iot-academy-edge-device** and click **Save**

   ![Create Edge Device Save.](./media/add-edge-device-portal-save.png 'Create Edge Device Save')

   After Creation your device will be available with new information, **Click** on the device

 ![Edge Device Created.](./media/add-edge-device-portal-created.png 'Edge Device Created')

   - Copy and paste into a notepad the connection string for your device, you will need this to connect your device to IoT hub, we will use this connection string later.

![Portal Connection String.](./media/edge-device-portal-connectionstring.png 'Device Connection String')



### **Task 2: Creating a VM to host an IoT Edge Device**

In this exercise we'll set up an IoT Edge device using an Ubuntu based VM.

1. From Azure Portal select **Create resource** then from the most Popular list select **Ubuntu Server 18.04 LTS**. If you don't see it use the search box titled **Search services and marketplace** to search for **Ubuntu Server 18.04 LTS**.

   ![Portal Create Ubuntu VM.](./media/edge-device-create-ubuntu-vm.png 'Create Ubuntu VM')
<br/>

2. Then you will need to complete the following parameters in the **Basics** tab:

   - **Subscription**: Select the subscription you are using for this hands-on lab.
   - **Resource group**: Use existing and select your resource group, `rg-iot-academy`.
   - **Virtual Machine Name**: edgedevice+SUFFIX e.g. `edgedevice-johndoe-220427`
   - **Region**: Select the location you are using for resources in this hands-on lab.
   - **Availability Options**: Select **No Infrastructure redundancy required**.
   - **Image**: Keep default
   - **Size**: Keep default
   - **Authentication Type**: Select **Password**
   - **Username**: iotacademy
   - **Password**: MSFTacademy01!
   - **Public inbound ports**: None
<br/>

3. Click the **Management** tab at the top of the pane.
 ![Create VM Management Tab.](./media/edge-device-create-ubuntu-vm-management.png 'Create VM Management Tab')

   Notice the Auto-shutdown feature. This feature is a helpful to control costs for development or infrequently used virtual machines. When the VM is shutdown you do not incur compute costs.
   ![Management tab Auto-shutdown feature.](./media/edge-device-create-ubuntu-vm-management2.png 'Management tab Auto-shutdown feature')
<br/>

4. Click the Tags tab
Add the following two tags
- environment: development
- product: iot-academy-training

   <br/>
   Diagram showing the tags tab while creating a VM

   ![Set tags.](./media/edge-device-create-ubuntu-vm-tags.png 'Set tags')

   <br/>

   Tags are an important aspect for management, governance, and hygiene of Azure resources. It's not uncommon to have thousands of resources in mature organizations. The tags can be used for search, reporting, and automation tools to ease management of large deployments.
   You can read more at [Azure Tagging Strategy](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging)

<br/>

5. Last select **Review + Create** after successfull validation you should be able to click **Create**
<br/>

6. Once the resource is available click **Go to resource** to view the newly created Virtual Machine. You should see in the Overview section the Public IP to connect, copy the IP to your notepad.

   ![Virtual Machine IP.](./media/edge-device-ubuntu-vm-ip-address.png 'Virtual Machine IP')

<br/>

### **Task 3: Connecting to your Ubuntu Virtual Machine**

An important aspect of building cloud infrastructure is doing it in a secure manner.
As part of this exercise port 22 could be opened, for SSH, to allow quick connection to the VM. However, this could allow an attacker to attempt to breach this port.
Two safer approaches could be used
   - A safer approach would be to use an important feature of Azure Virtual Machines, Just-in-time (JIT) VM access. This feature allows enabling access to the VM for a specified amount of time. More information can found at [Just-in-time VM Access](https://docs.microsoft.com/en-us/azure/defender-for-cloud/just-in-time-access-usage)
   - Enabling SSH, port 22, access for just your IP address

For simplicity the 2nd option will be used.
<br/>

1. Go to [www.bing.com](https://www.bing.com) in your browser and search for `what is my ip`

   ![What is my IP?](./media/ubuntu-vm-networking-find-my-ip.png 'What is my IP?')
<br/>
   Copy your IP address to your notepad.
<br/>

2. On your VM resource click the **Networking** tab. Click the `Add inbound port rule`

   ![VM add inbound rule.](./media/ubuntu-vm-networking-add-inbound-port-rule.png 'VM add inbound rule')

<br/>

3. Set the details for the new inbound port rule, click Add.

   - Source: `IP Addresses`
   - Source IP addresses/CIDR ranges: `Your IP address you saved in notepad`
   - Source port ranges: `*`
   - Service: `SSH`
   - Action: `Allow`
   - Priority: `100`
   - Name: `Port_22`

   ![VM add inbound rule details.](./media/ubuntu-vm-networking-add-inbound-port-rule-details.png 'VM add inbound rule details')

<br/>

4. Watch for the notification that the security rule created successfully

   ![VM add inbound rule completed notification.](./media/ubuntu-vm-networking-add-inbound-port-rule-completed-notification.png 'VM add inbound rule completed notification')

<br/>

5. Switch to VS Code, use the **View** menu and click **Terminal**

   ![VS Code View Terminal.](./media/vscode-view-terminal.png 'VS Code View Terminal')

   ![VS Code Terminal.](./media/vscode-terminal-bash.png 'VS Code Terminal')

   If you don't see a `bash` terminal at the top, click the `+` and click `bash`
<br/>

6. Enter `ssh iotacademy@{the public IP address of your VM}` and press enter. You saved the VMs public IP address earlier in your notepad. Be sure to not confuse your public IP address with the IP address of the VM.
e.g. `ssh iotacademy@20.122.53.2`

<br/>
   If this is your first time connecting you'll see a prompt asking `Are you sure you want to continue connecting?`. Enter `yes` and press enter.

   ![VS Code Terminal Continue Connecting.](./media/vscode-terminal-fingerprint-yes.png 'VS Code Terminal Continue Connecting')

<br/>

7. Enter your password you defined earlier `MSFTacademy01!` and press enter. The password can be copied to your clipboard and pasted into the terminal by:
   - left clicking on the terminal window once, to focus the window
   - right clicking on the terminal window once, this pastes the clipboard contents
<br/>

   After successfully connecting you'll see the following in your terminal
   
   ![VS Code Terminal Connected.](./media/vscode-terminal-connected.png 'VS Code Terminal Connected')
<br/>

### **Task 4: Install the Azure IoT Edge Runtime**

1. Now logged into the VM, Install the Edge Runtime

   Install the repository configuration that matches your device operating system.

   ```bash
   curl https://packages.microsoft.com/config/ubuntu/18.04/multiarch/prod.list > ./microsoft-prod.list
   ```

   Copy the generated list to the sources.list.d directory.

   ```bash
   sudo cp ./microsoft-prod.list /etc/apt/sources.list.d/
   ```

   Install the Microsoft GPG public key.
   ```bash
   curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
   sudo cp ./microsoft.gpg /etc/apt/trusted.gpg.d/
   ```

   Azure IoT Edge software packages are subject to the license terms located in each package (usr/share/doc/{package-name} or the LICENSE directory). Read the license terms prior to using a package. Your installation and use of a package constitutes your acceptance of these terms. If you do not agree with the license terms, do not use that package.

   After successfully running the previous commands you'll the following results depicted in the diagram.

   ![Package sources complete](./media/ssh-configure-add-package-sources-complete.png 'Package sources complete')

2. Install a Container Engine

   Update package lists on your device.
   ```bash
      sudo apt-get update
   ```

   Install the Moby engine.
   ```bash
      sudo apt-get install moby-engine
   ```

3. Install the IoT Edge runtime package

   ```bash
      sudo apt-get install iotedge
   ```

4. Edit the IoT Edge config.yaml, updating the connection string
   
   Configure the connection to your IoT Hub, we will apply the connection string you copied in Task 1. Open the configuration file in your device to edit the connection string with the following command.

   ```bash
      sudo nano /etc/iotedge/config.yaml
   ```

   Once in the nano editor, scroll down to **Manual Provisioning configuration using a connection string** then replace the **device_connection-string** variable wit the connection string from the task 1.

   ![Config File.](./media/ssh-edit-iot-edge-connectionstring.png 'Config File')

   After setting your connection string:
      - press **CrtL+X** to close the file 
      - select  **Y** to save the changes
      - press enter to accept the file name

   Now restart your edge daemon
   ```bash
      sudo systemctl restart iotedge
   ```

   In a few minutes you should receive a **Running** status after executing the following command. You may need to run the command several times if enough time has not passed since restarting the IoT Edge runtime.
   ```bash
      sudo iotedge list
   ```

