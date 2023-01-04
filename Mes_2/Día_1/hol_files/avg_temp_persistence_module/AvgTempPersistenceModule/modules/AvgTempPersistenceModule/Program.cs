namespace AvgTempPersistenceModule
{
    using System;
    using System.IO;
    using System.Runtime.InteropServices;
    using System.Runtime.Loader;
    using System.Security.Cryptography.X509Certificates;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using Microsoft.Azure.Devices.Client;
    using Microsoft.Azure.Devices.Client.Transport.Mqtt;
    using Microsoft.Data.SqlClient;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;

    class Program
    {
        static int counter;
        static string _ConnectionString = "Data Source=azuresqledge;Database=**DATABASE**;Integrated Security=false;User ID=sa;Password=password1!test;TrustServerCertificate=True;";

        static void Main(string[] args)
        {
            Init().Wait();

            // Wait until the app unloads or is cancelled
            var cts = new CancellationTokenSource();
            AssemblyLoadContext.Default.Unloading += (ctx) => cts.Cancel();
            Console.CancelKeyPress += (sender, cpe) => cts.Cancel();
            WhenCancelled(cts.Token).Wait();
        }

        /// <summary>
        /// Handles cleanup operations when app is cancelled or unloads
        /// </summary>
        public static Task WhenCancelled(CancellationToken cancellationToken)
        {
            var tcs = new TaskCompletionSource<bool>();
            cancellationToken.Register(s => ((TaskCompletionSource<bool>)s).SetResult(true), tcs);
            return tcs.Task;
        }

        /// <summary>
        /// Initializes the ModuleClient and sets up the callback to receive
        /// messages containing temperature information
        /// </summary>
        static async Task Init()
        {
            MqttTransportSettings mqttSetting = new MqttTransportSettings(TransportType.Mqtt_Tcp_Only);
            ITransportSettings[] settings = { mqttSetting };

            // Open a connection to the Edge runtime
            var moduleClient = await ModuleClient.CreateFromEnvironmentAsync(settings);
            await moduleClient.OpenAsync();
            Console.WriteLine("IoT Hub module client initialized.");

            // Register callback to be called when a message is received by the module
            await moduleClient.SetInputMessageHandlerAsync("input1", PipeMessage, moduleClient);
        }

        /// <summary>
        /// This method is called whenever the module is sent a message from the EdgeHub. 
        /// It just pipe the messages without any change.
        /// It prints all the incoming messages.
        /// </summary>
        static async Task<MessageResponse> PipeMessage(Message message, object userContext)
        {
            int counterValue = Interlocked.Increment(ref counter);

            var moduleClient = userContext as ModuleClient;
            if (moduleClient == null)
            {
                throw new InvalidOperationException("UserContext doesn't contain " + "expected values");
            }

            byte[] messageBytes = message.GetBytes();
            string messageString = Encoding.UTF8.GetString(messageBytes);
            Console.WriteLine($"Received message: {counterValue}, Body: [{messageString}]");

            if (!string.IsNullOrEmpty(messageString))
            {
                using (var pipeMessage = new Message(messageBytes))
                {
                    var temp = JsonConvert.DeserializeObject<AverageTemp>(messageString);

                    try
                    {
                        await InsertAverageTemp(temp);
                        Console.WriteLine("Successfully inserted to SQL");
                    } 
                    catch(Exception exc)
                    {
                        Console.WriteLine($"Failed to insert to SQL.\r\n{exc}");
                    }

                    await moduleClient.SendEventAsync("output1", pipeMessage);
                
                    Console.WriteLine("Received message sent");
                }
            }
            return MessageResponse.Completed;
        }

        static async Task InsertAverageTemp(AverageTemp temp)
        {
            //CreateDBIfNotExists("AverageTemperature");

            var connectionString = "Data Source=azuresqledge;Database=AverageTemperature;Integrated Security=false;User ID=sa;Password=password1!test;TrustServerCertificate=True;";

            using(var connection = new SqlConnection(connectionString))
            {
                await connection.OpenAsync();
                Console.WriteLine("Sql Connection Opened.");

                var sql = $"INSERT INTO AverageTemperature (WindowEnd, AverageTemperature) VALUES ('{temp.WindowEnd}',{temp.AverageTemperature})";

                 var command = connection.CreateCommand();
                 command.CommandText = sql;
                 await command.ExecuteNonQueryAsync();
            }
        }

        static string GetConnectionString(string database)
        {
            return _ConnectionString.Replace("**DATABASE**", "master");
        }

//         static async Task CreateDBIfNotExists(string dbName)
//         {
//             using(var connection = new SqlConnection(GetConnectionString("master")))
//             {
//                 var sql = $"SELECT COUNT(*) FROM sys.databases where name='{dbName}'";

//                  var command = connection.CreateCommand();
//                  command.CommandText = sql;
//                  var exists = await (Int32)command.ExecuteScalar() == 0 ? false : true;

//                  if(exists)
//                  {
//                      return;
//                  }

//                 sql = @" 
// IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = '**DATABASE**')
//   BEGIN
//     CREATE DATABASE [DataBase]


//     END
//     GO
//        USE [**DATABASE**]
//     GO
// --You need to check if the table exists
// IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TableName' and xtype='U')
// BEGIN
//     CREATE TABLE AverageTemperature (
//         When datetime PRIMARY KEY,
//         AverageTemperature float(24)
//     )
// END".Replace("**DATABASE**", database);

//                  var command = connection.CreateCommand();
//                  command.CommandText = sql;
//                  command.ExecuteNonQueryAsync();
//             }            
//         }
    }
}
