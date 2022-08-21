# **Azure IoT Central - 动手实验** #


**场景**

假设您经营一家管理冷藏卡车车队的公司。 您在某个城市中有很多客户，基于客户的需求在货运中心来管理这些业务工作。 您需要安排每辆卡车运输冷藏物品交付给客户。

如果发现卡车上的冷却系统发生故障并且运输物品开始融化，您需要告诉卡车返回基地并卸下运输物品。 或者，您也可以在冷却系统出现故障时将运输物品交付给附近的客户。

要做出这些决定，您需要了解卡车发生问题的最新情况，包括每辆卡车在地图上的位置、冷却系统的状态以及运输物品的状态。

Azure IoT Central 提供了处理此场景所需的一切。 例如，在下图中，彩色圆圈显示了一辆卡车在前往客户途中的位置。

**交付的应用**

在本动手实验结束时，您将会完成的应用程序应如下图所示

 ![Create a Custom App](./media/iotcentral-app.png 'Create a Custom App')

**动手实验前所需要的准备**
- Microsoft Azure 订阅
- 安装好 Visual Studio Code

## **动手实验步骤:** ##
- [实验一: 创建自定义 Azure IoT Central 应用](#exercise-1-create-a-custom-iot-central-app)
  - [任务一: 创建应用](#task-1-creating-an-application)
   - [任务二: 为您的应用添加遥测功能](#task-2-add-capabilities---telemetry)
    - [任务三: 为您的应用添加属性](#task-3-add-capabilities---properties)
    - [任务四: 为您的应用添加命令](#task-4-add-capabilities---commands)
<br/><br/>

- [实验二: 创建仪表板](#exercise-2-create-a-dashboard)
    - [任务一: 让你的设备可视化](#task-1-visualizing-the-device)
    - [任务二: 添加可写属性视图](#task-2-writable-properties-view)
    - [任务三: 创建设备](#task-3-create-a-device)
<br/><br/>

- [实验三:  Azure 地图](#exercise-3-azure-maps)
<br/><br/>

- [实验四: 创建设备应用](#exercise-4-create-the-device-app)
    - [任务一: 创建你的开发环境](#task-1-set-up-your-environment)
    - [任务二: 运行你的设备](#task-2-launch-your-device)
    - [任务三: 设置属性](#task-3-set-up-properties)
<br/><br/>

- [实验五: 创建规则](#exercise-5-create-rules)
    - [实验一: 冷却系统状态](#task-1-cooling-system-state)
    - [实验二: 温度飙升](#task-2-temperature-spiking)
    - [实验三: 卡车离开货运中心](#task-3-truck-leaves-base)
    - [实验四: 运输物品的温度](#task-4-temperature-of-the-contents)
<br/><br/>

- [Exercise 6: Clean up](#exercise-6-clean-up)
<br/><br/>

## **实验一: 创建自定义 Azure IoT Central 应用** ##

### **任务一: 创建应用** ###

**打开您的浏览器:**

通过 Azure Pass 创建您的 Azure 订阅后，登录 Azure 账户后进入 https://portal.azure.com/

打开 Azure IoT Central: https://apps.azureiotcentral.com/

 ![Create a Custom App](./media/iotc-custom-app.png 'Create a Custom App')

选择左侧的创建图标，然后选择在 "自定义应用 / Custom app" 中创建应用 ( Create app )。 您需要填写申请表中的字段：

 ![Create a Custom App](./media/iotc-new-app.png 'Create a Custom App')

- **应用名字 - Application Name:** 可以用与冷藏车项目有关的名字

- **URL:** refrigerated-trucks-**后序** 必须是唯一的 URL

- **应用模版 - Application Template:** 使用默认模版 - Custom Application

- **付费计划:** 请选择 " Standard 1 " 

- **目录:** 您的订阅所在的目录，通常是与您的登录关联的“默认目录”。

- **Azure 订阅:** 选择您的 Azure 订阅

- **所在位置** 选择您所在 IoT Central 所在位置

所有都确认填写好后，点击 **创建 - Create**

创建成功后，下一步需要**创建设备模板**。 在左侧菜单中单击 **设备模版 - Device Templates** 按钮，然后再点击 **新建 - New**

 ![Create a new device template](./media/iotc-device-template.png 'Create new template')

<br> 

1. 选择 **IoT 设备 - IoT Device** 然后点击 **下一步: 定制 - Next: Customize**
2. 在自定义中分配一个**Device Template name - 设备模板名称** RefrigeratedTruck
3. 不要选择**网关设备 - Gateway device**框
4. 选择**下一步：查看 - Next: Review**。 然后选择**创建 - Create**
5. 在创建模型区域中，选择自定义模型。 您的视图现在应该类似于下图
 
 <br> 

6. 单击**模型 - Model **，然后选择**添加继承的接口 - Add an inherited interface**

![Add an inherited interface](./media/iotc-inherited-interface.png 'Add an inherited interface')

7. 选择**自定义**, 从空白界面开始构建

 ![Create a new Model](./media/iotc-create-model.png 'Create new Model')

<br> 


### **任务二: 为您的应用添加遥测功能** ###

**注意**：接口名称必须完全按照本练习要求去输入。 名称和条目必须与您稍后将在本模块中添加的代码对应。

1. 首先，请选择 **“添加功能 - Add capability”** 并单击向下图标以显示所有字段。

 ![Add capability](./media/iotc-add-capability-1.png 'Add capability')

2. 在字段内依次输入以下值

<br/>

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Contents temperature |
| 名称 - Name | ContentsTemperature |
| 功能类型 - Capability type | Telemetry |
| 语意类型 -  Semantic Type | Temperature |
| 结构类型 - Schema | Double |
| 单位 - Unit | Degree celsius |

<br/>

确认您填写的功能如下图所示:

![Add Capability](./media/iotc-add-capability-2.png 'Add Capability')

<br/>

3. 每个状态都是很重要。 他们让操作员知道发生了什么。 IoT Central 中的状态是与一系列值关联的名称。 稍后您将选择与每个值关联的颜色.

使用 **添加功能 - Add capability** 控件为卡车的冷藏内容添加状态：**empty**、**full** 或 **melting**

<br/>

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Contents state |
| 名称 - Name | ContentsState |
| 功能类型 - Capability type | Telemetry |
| 语意类型 - Semantic Type | State |
| 结构类型 - Schema | String |

<br/>

选择 **添加 - Add**.

![Add State value](./media/iotc-state-values-add.png 'Add State value')

对于显示名称和值，输入空。 名称字段应自动填充为空。 所以所有三个字段都是相同的，包含**empty**。 添加另外两个状态值：**full** 和 **melting**。 同理相同的文本应该出现在显示名称、名称和值的字段中。

![Add Capability](./media/content-state.png 'Add Capability')

<br/> 

4. 如果冷却系统出现故障，正如您将在以下内容中看到的那样，货物融化的机会会大大增加。

<br/>

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Cooling system state |
| 名称 - Name | CoolingSystemState |
| 功能类型 - Capability type | Telemetry |
| 语意类型 - Semantic Type | State |
| 结构类型 - Schema | String |

<br/> 

为冷却系统添加 **on**、**off** 和 **failed** 条目。 首先选择添加功能。 然后添加另外一个状态：:

![Cooling System State](./media/cooling-system.png 'Cooling System states')

5. 更复杂的状态是卡车本身的状态。 如果一切顺利，卡车的正常路线可能已准备就绪，在途中、交付、返回、装载，然后再次准备就绪。 还要添加倾倒状态以说明处理融化货物！ 要创建新状态，请使用与刚才最后两个步骤相同的过程。

<br/>

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Truck state |
| 名称 - Name | TruckState |
| 功能类型 - Capability type | Telemetry |
| 语意类型 - Semantic Type | State |
| 结构类型 - Schema | String |

<br/> 

现在添加：**ready**、**enroute**、**delivering**、**returning**、**loading**、**dumping**，如下图：

<br> 


![Truck State](./media/truck-state.png 'Truck states')

<br> 

6. 添加事件功能。 设备可能会触发一个事件 - 冲突指令。 一个例子可能是当一辆从客户那里返回的空卡车收到将其内容交付给另一个客户的命令时。 如果发生冲突，设备应触发事件以警告 IoT Central 应用程序的操作员。

另一个事件可能只是确认并记录卡车要交付的客户 ID。

要创建事件，请选择**添加功能 - Add capability**。 然后填写以下信息。

<br/>

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Event |
| 名称 - Name | Event |
| 功能类型 - Capability type | Telemetry |
| 语意类型 - Semantic Type | Event |
| 结构类型 - Schema | String |
| 严重性 - Severity | Information |

<br/>

设置如下图所示：

![Truck State](./media/event.png 'Truck states')

<br> 
7. 使用以下信息添加位置功能:

<br/> 

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Location |
| 名称 - Name | Location |
| 功能类型 - Capability type | Telemetry |
| 语意类型 - Semantic Type | Location |
| 结构类型 - Schema | Geopoint |

<br/>

### **任务三: 为您的应用添加属性** ###

将卡车货物的最佳温度定义为属性。

1. 选择 "添加 - Add" 功能。 然后添加卡车 ID 属性。

<br/>

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Truck ID |
| 名称 - Name | TruckID |
| 功能类型 - Capability type | Property |
| 语意类型 - Semantic Type | None |
| 结构类型 - Schema | String |
| 可写 - Writable | Off |
| 单位 - Unit | None |

<br/>

您的属性设置如下:

![Truck State](./media/truckid-property.png 'Truck states')

2. 添加最佳温度属性

<br/>

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Optimal Temperature |
| 名称 - Name | OptimalTemperature |
| 功能类型 - Capability type | Property |
| 语意类型 - Semantic Type | Temperature |
| 结构类型 - Schema | Double |
| 可写 - Writable | On |
| 单位 - Unit | Degree celsius |

<br/>

如下图所示:

![Truck State](./media/optimal-temp.png 'Truck states')


### **任务四: 为您的应用添加命令** ###
对于冷藏车，您应该添加两个命令：

将内容交付给客户的命令
将卡车召回基地的命令

1. 要添加命令，请选择**添加功能 - Add capability** 添加第一个命令

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Go to customer |
| 名称 - Name | GoToCustomer |
| 功能类型 - Capability type | Command |

<br/>

打开 **请求 - Request** 选项以输入更多命令相关详细信息。

<br/>

| **输入对应字段** | **相关值** |
|---|---|
| 请求 - Request | On |
| 显示名称 - Display Name | Customer ID |
| 名称 - Name | Customer ID |
| 结构类型 - Schema | Integer |

<br/>

使用下图验证您的输入是否一致:

![Command Go to Customer](./media/command-go-to-customer.png 'Command Go to Customer')

<br/>

2. 创建一个命令来召回卡车。

| **输入对应字段** | **相关值** |
|---|---|
| 显示名称 - Display Name | Recall |
| 名称 - Name | Recall |
| 功能类型 - Capability type | Command |

<br> 

您的召回属性应如下图所示:

![Command Recall](./media/command-recall.png 'Command Recall')

<br> 

3. 在继续之前，请仔细检查您的界面。 发布界面后，编辑选项受到限制。 所以你应该在发布之前把它弄好。

当您选择设备模板的名称时，以“视图”选项结尾的菜单总结了功能，合共6 个基于遥测，2 个属性和 2 个命令: 

![Summary list](./media/capabilities-all.png 'Summary List')

4. 选择**保存 - Save**，然后选择**发布 - Publish**

![Save and Publish](./media/iotc-iface-save-pub.png 'Save and Publish')

5. 在对话框中，再次选择 **发布 - Publish**。 注释应从 ***草稿 - Draft*** 更改为 ***已发布 - Published***。

![Published](./media/iotc-iface-published.png 'Published')

## 实验二: 创建仪表板 ## 

### **Task 1: Visualizing the device** ### 

1. Select **Views**. Then select **Visualizing the device**.

![Device](./media/dashboard-view.png 'Visualizing Device')

2. Change the View name to something more specific, for example, **Truck view**

3. Click **Start with devices** under **Add a tile**.

![Create view](./media/iotc-view-1.png 'Create view')

3. Under **Telemetry**, select **Location** in the dropdown, then scroll to the bottom to click **Add tile**. Dashboards are made of tiles. We choose the location tile first because we want to expand it.

![Telemetry location tile add](./media/iotc-view-2.png 'Telemetry location tile add')

4. Select each of the rest of the telemetry and property capabilities that you created, starting at the top. For each capability, select **Add tile** at the bottom.

<br/>

**Telemetry:** Location, Contents state, Contents temperature, Cooling system state, Event, Truck state<br/>
**Property:** Optimal Temperature, Truck ID<br/>

Your new Dashboard should look like this one:

![Dashboard](./media/dashboard-device.png 'New Dashboard')

5. Click **Save** to save this view and **Back** to return to the device template.


### **Task 2: Writable Properties View** ### 

We need to create a separate view. Its sole purpose will be to set writable properties.

1. Select **Views**, and then select the **Editing device and cloud data** tile.

![Writable properties](./media/editingdevice.png 'Properties')

2. Change the form name to something like **Set properties**.

3. Select the **Optimal temperature** property check box. Then click **Add section**.

4. Verify that your view looks similar to the following image. Then click **Save** to save this view and **Back** to return to the device template.

![Writable properties](./media/writeable-form.png 'Properties')

5. Select **Publish**. Then in the dialog box, select **Publish** again.

### **Task 3: Create a Device** ### 

1. On the menu on the left, click **Devices**, select **RefrigeratedTruck**, and click **New**.

![Create Device](./media/createdevice.png 'Create Device')

2. In the Create a new device dialog box, verify that the device template is **RefrigeratedTruck**.

<br/>

- **Device name**: RefrigeratedTruck - 1
- **Device ID**: RefrigeratedTruck1
- **Device template**: RefrigeratedTruck (default)
- **Simulate this device?**: No (default)

<br/>

![New Device](./media/new-device.png 'New Device')

4. Click **Create**. Notice that the Device status is **Registered**. Only after the device status is **Provisioned** will the IoT Central app accept a connection to the device. The coding unit that follows shows how to provision a device.

5. Click **RefrigeratedTruck - 1**, then **Truck view** to see the live dashboard, where all the tiles will show *No data found* because we don't have any telemetry yet. On the bar that includes **Truck view**, click **Commands** where you will see the two commands you entered are ready to run.

6. In the upper-right, click **Connect**.

In the Device connection dialog box that opens, carefully copy the **ID scope**, **Device ID**, and **Primary key**. The ID scope identifies the app. The device ID identifies the real device. And the primary key gives you permission for the connection.

Paste this information in a text file. 

Leave the Authentication type setting as **Shared access signature (SAS)**.

After you save the IDs and the key, select Close on the dialog box.

## Exercise 3: Azure Maps ## 

1. Go to Azure Portal: https://portal.azure.com/
2. Click **Create a Resource** then in the search box type **Azure Maps**. Open the Azure Maps service page and click **Create**.

![Azure Maps](./media/azure-maps.png 'Azure Maps')

Complete the creation form: 
- **Subscription**: Select the subscription you are using for this training if it is not currently selected.
- **Resource group**: IOTC
- **Name**: mytrucksacademy**SUFFIX**
- **Region**: Select the region you are using for this training. 
- **Pricing tier**: Gen1 (S1)
- **License and Privacy Statement** Checked

<br/>

Then click **Review + create** at the bottom of the page, then click **Create** at the bottom of the review page.

![Create Azure Maps](./media/azure-maps-form.png 'Create Azure Maps')

Once Azure Maps resource is created, click **Go to resource** then find the key on the **Authentication** blade. Copy the **Primary key** and paste it into your notepad. 

![Azure Maps Auth](./media/azure-maps-auth-key.png 'Azure Maps Auth')

## Exercise 4: Create the device app ## 

### **Task 1: Set up your environment** ###

1. Open Visual Studio Code locally

2. On the top bar select **Terminal** and then **New Terminal** in Visual Studio Code. 

3. Please make sure you are in the local directory where you want to create a new directory. (cd.. to change directory location locally)

![Terminal](./media/vs-code-mkdir.png 'Terminal')

4. Run the following commands to create a directory, set up a dotnet environment, and install required libraries:

```
mkdir RefrigeratedTruck
cd RefrigeratedTruck
dotnet new console
dotnet restore
dotnet add package AzureMapsRestToolkit
dotnet add package Microsoft.Azure.Devices.Client
dotnet add package Microsoft.Azure.Devices.Provisioning.Client
dotnet add package Microsoft.Azure.Devices.Provisioning.Transport.Mqtt
dotnet add package System.Text.Json

```

5. From the File menu, open the Program.cs file just created. On the github repo month 1/day 1 there is a folder titled Code-Sample: https://github.com/AzureIoTGBB/iot-academy/tree/main/Month_1/Day_1/Code_sample Copy this content from the Prgram.cs file and paste into your Visual Studio code Program.cs file. This will replace the whole content.

6. Once you replace the content of the files, we need to add our keys to connect with our services. Look for lines **123** to **126**. Replace accordingly based on the keys you were adding to your notepad in previous exercises.

 ![Command Recall](./media/vscode-replace-keys.png 'Command Recall')

After the changes are made, save the file. Click **File - Save **
### **Task 2: Launch your device** ### 

1. To begin testing, first open the Azure IoT Central app in a browser: https://app.azureiotcentral.com/
    Click **My apps** on the left.
    Click the **Refrigerated Truck IoT** tile.

2. In the VS Code terminal, start the device app using the following command:

```
dotnet run
```

A console screen opens with the message Starting Truck number 1.

 ![Command Recall](./media/register-device.png 'Command Recall')

Once your device in registered through VS Code, you should see in your IoT Central an status change to **Provisioned**:

 ![Command Recall](./media/device-provisioned.png 'Command Recall')

At this point in the Truck View dashboard in IoT Central you should see data flowing thorught it, the map should show a blue dot with your truck and the chart receiving telemetry data should show some data points already.

3. Select the device's **Commands** tab. This control should be under the truck name, to the right of the Truck view control.

4. Enter a customer ID, say **1**. (Numerals 0 through 9 are valid customer IDs.) Then select **Run**.

In the console for the device app, you see both a New customer event and a Route found message

 ![Command Recall](./media/new-command.png 'Command Recall')


5. On the dashboard's Location tile, check to see whether your truck is on its way. You might have to wait a short time for the apps to sync.

6. Verify the event text on the Event tile. You should see a new Customer Event.

7. When the truck returns to base and is reloaded with contents, its state is ready. Try issuing another delivery command. Choose another customer ID.

8. Before the truck reaches the customer, make a recall command to check whether the truck responds.


### **Task 3: Set up Properties** ### 


The next test is to check the writable property, **OptimalTemperature**. To change this value, select the **Set properties** view.

Set the optimal temperature to any value, say **-8**. Select **Save** and then notice the Pending status.

 ![Command Recall](./media/set-property.png 'Command Recall')

Now you should see the new Optimal temperature is set to -8. in the **Optimal Temperature** Tile.


## Exercise 5: Create Rules ## 

### **Task 1: Cooling system state** ###

1. In the IoT portal, select **Rules** in the left-hand menu, then **+ New**. Enter a meaningful name for the rule, such as **"Cooling system failed"**. Press Enter.

 ![Rules](./media/new-rule.png 'New Rule')



 2. Select **RefrigeratedTruck** for the **device template**.

3. Under **Conditions** notice that all the telemetry elements of the device template are available. Select **Cooling system state**.

For Operator, select **Equals**.

For value, type the word **"failed"**, then click on Select: "failed".

Leave Time aggregation as Off.

For **Actions**, click on **+ Email**.

In Display name, enter a title for the email, perhaps "Cooling system failed!"

For To, enter the email you've used for your IoT Central account. And for Note enter some descriptive text that will form the body of the email.

**Note**: To receive emails the account you select has to be login to IoT central at least one time, otherwise you will not receive any emails.

Your new rule should look like the below image.

 ![Rules](./media/rule-cooling-system.png 'New Rule Cooling System')


### **Task 2: Temperature spiking** ###

1. Create a new rule with a name such as **"Contents temperature spiking"**.

2. Turn on **Time aggregation**, and select an interval of **5 minutes**.

3. Select **Contents Temperature** for Telemetry.

4. In the range Aggregation values, select **Maximum.**

5. For Operator. select Is greater than or equal to. Then enter **"0"** for the value, and select that as the value.

6. For Actions, fire off another email. Give the email an appropriate title and note.

7. Make sure to click Save, to save off this rule.


 ![Rules Temp](./media/temp-spiking.png 'New Rule Temp System')

### **Task 3: Truck leaves base** ###

1. Select **Rules** in the left-hand menu, then **+ New**. Enter a meaningful name for the rule, such as **"Truck leaving base"**. Press Enter.

Now, enter the following conditions.
- Location / Latitude: doesn't equal => **47.644702**
- Location / Longitude: doesn't equal => **-122.130137**
- Truck state: Equals => **enroute**

2. Again, enter an appropriate **email action**, and click **Save**.

### **Task 4: Temperature of the contents** ###

1. Enter a rule with a name such as **"Truck contents OK"**.

2. Turn on Time aggregation, with a period of **five minutes**.

3. Enter conditions that fire if the average Contents Temperature is less than **-1** degrees Celsius, and greater than **-18** degrees Celsius.

4. Again, enter an appropriate **email action**, and click **Save**.

At this point you should see all the rules listed as below:

 ![Rules Temp](./media/rules-all.png 'New Rule Temp System')


At this point it is time to test your Rules Go to your Device Dashboard, sent a Command to trigger a new Customer trip, remember use numbers from 1 to 9.
In a few minutes you should start receiving emails.

**Note**: To receive emails the account you select has to be login to IoT central at least one time, otherwise you will not receive any emails.


## Exercise 6: Clean up ## 

**Once you completed all the exercises, go to Azure Portal, look for the azure IoT Central Application and delete resource.
