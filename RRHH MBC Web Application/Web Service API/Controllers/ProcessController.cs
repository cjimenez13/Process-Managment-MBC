using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/process")]
    public class ProcessController : ApiController
    {
        [HttpGet]
        public IEnumerable<ProcessDTO> Get()
        {
            List<ProcessDTO> processes = ProcessData.getProcesses();
            return processes;
        }
        [HttpGet]
        public ProcessDTO GetProcess(string id_process)
        {
            ProcessDTO process = ProcessData.getProcess(id_process);
            return process;
        }
        [HttpPost]
        public IHttpActionResult Post(ProcessDTO processDTO)
        {
            if (!ProcessData.insertProcess(processDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        public IHttpActionResult Put(ProcessDTO processDTO)
        {
            if (!ProcessData.updateProcess(processDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpDelete]
        public IHttpActionResult Delete(string id_process, string userLog)
        {
            if (!ProcessData.deleteProcess(id_process, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }
    }
}
