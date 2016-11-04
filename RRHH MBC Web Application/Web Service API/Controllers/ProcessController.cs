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
        public IEnumerable<ProcessDTO> GetProcessbyUser(string user_id)
        {
            List<ProcessDTO> processes = ProcessData.getProcessesbyUser(user_id);
            return processes;
        }
        [HttpGet]
        public ProcessDTO GetProcess(string id_process)
        {
            ProcessDTO process = ProcessData.getProcess(id_process);
            return process;
        }
        [HttpPost]
        public string Post(ProcessDTO processDTO)
        {
            return ProcessData.insertProcess(processDTO);
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
        [Route("bifurcate")]
        [HttpPut]
        public IHttpActionResult bifurcateProcess(BifurcateProcessDTO bifurcateDTO)
        {
            if (!ProcessData.bifurcateProcess(bifurcateDTO))
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
        [HttpGet]
        [Route("states")]
        public IEnumerable<ProcessStateDTO> getProcessStates()
        {
            List<ProcessStateDTO> processesStates = ProcessData.getProcessStates();
            return processesStates;
        }
    }
}
