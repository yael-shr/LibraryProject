using System.Security.Principal;

using System.Collections.Generic;
namespace ServerHouses
{
    public class MyJson
    {
        public string procedureName { get; set; }
        public Dictionary<string,object> parameters { get; set; }
    }
}
