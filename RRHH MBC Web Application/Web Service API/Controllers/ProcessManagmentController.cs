using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/processManagment")]
    public class ProcessManagmentController : ApiController
    {
        [HttpGet]
        [Route("participants")]
        public List<ParticipantDTO> getParticipants(string id_process)
        {
            List<ParticipantDTO> participants = ProcessManagmentData.getProcessParticipants(id_process);
            return participants;
        }
        [HttpPost]
        [Route("participants")]
        public IHttpActionResult postParticipant(ParticipantDTO templateDTO)
        {
            if (!ProcessManagmentData.insertParticipant(templateDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpPost]
        [Route("group")]
        public IHttpActionResult postGroup(ParticipantDTO templateDTO)
        {
            if (!ProcessManagmentData.insertGroup(templateDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpDelete]
        [Route("participants")]
        public IHttpActionResult deleteParticipant(string id_process, string userLog, string user_id)
        {
            if (!ProcessManagmentData.deleteParticipant(id_process, userLog, user_id))
            {
                return BadRequest();
            }
            return Ok();
        }
    }
}
