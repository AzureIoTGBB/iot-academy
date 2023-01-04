namespace AvgTempPersistenceModule
{
    using System;
    using System.IO;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;

    class AverageTemp
    {
        public DateTime WindowEnd {get;set;}
        public float AverageTemperature {get;set;}
    }
}