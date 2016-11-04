using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/scripts")]
    public class ScriptsController : ApiController
    {
        [HttpGet]
        public IEnumerable<ScriptsLogDTO> Get()
        {
            List<ScriptsLogDTO> scripts = ScriptsLogData.getScriptsLog();
            return scripts;
        }
        [HttpPost]
        public string Post(ScriptsLogDTO scriptDTO)
        {
            string result = "-1";
            if ((result = ScriptsLogData.executeSQL(scriptDTO)) != "")
            {
                if (!ScriptsLogData.insertScriptLog(scriptDTO))
                {
                    return result;
                }
            }
            return result;
        }
        [HttpPost]
        [Route("reexecute")]
        public string executeAgain(ScriptsLogDTO scriptDTO)
        {
            string result = "-1";
            if ((result = ScriptsLogData.executeSQL(scriptDTO)) != "")
            {
                return result;
            }
            return result;
        }
    }
}
