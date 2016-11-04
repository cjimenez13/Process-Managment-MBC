using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Model
{
    public class ScriptsModel
    {
        private ScriptsProvider scriptProvider = new ScriptsProvider();
        public List<ScriptsLogDTO> scriptsLog = new List<ScriptsLogDTO>();
        public ScriptsModel()
        {
            scriptsLog = scriptProvider.getScripts().Result;
        }
    }
    public class AddScriptModel
    {
        public AddScriptModel()
        {

        }
        public string scriptText { get; set; }
        public string scriptType { get; set; }
    }
    public class ScriptResultTable
    {
        public List<Dictionary<string, dynamic>> dictionaryRows;
        public ScriptResultTable(string json)
        {
           dictionaryRows = JsonConvert.DeserializeObject<List<Dictionary<string, dynamic>>>(json);
        }
    }
}
