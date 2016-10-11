using DataTransferObjects;
using System;
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
        public List<ParticipantDTO> postParticipant(List<ParticipantDTO> participantsDTO)
        {
            List<ParticipantDTO> insertedParticipants = new List<ParticipantDTO>();
            foreach (ParticipantDTO participant in participantsDTO)
            {
                try
                {
                    if (ProcessManagmentData.insertParticipant(participant))
                    {
                        insertedParticipants.Add(participant);
                    }
                }catch(Exception e)
                {
                    //e.Message;
                }
            }
            return insertedParticipants;
        }
        [HttpPost]
        [Route("groups")]
        public List<ParticipantDTO> postGroup(List<ParticipantDTO> groupsDTO)
        {
            List<ParticipantDTO> insertedGroups = new List<ParticipantDTO>();
            foreach (ParticipantDTO participant in groupsDTO)
            {
                try
                {
                    if (ProcessManagmentData.insertGroup(participant))
                    {
                        insertedGroups.Add(participant);
                    }
                }
                catch (Exception e)
                {
                    //e.Message;
                }
            }
            return insertedGroups;
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

        [HttpGet]
        [Route("stages")]
        public List<StageDTO> getStages(string id_process)
        {
            List<StageDTO> stages = ProcessManagmentData.getProcessStages(id_process);
            return stages;
        }
        [HttpGet]
        [Route("stages")]
        public StageDTO getStage(string id_stage)
        {
            StageDTO stage = ProcessManagmentData.getProcessStage(id_stage);
            return stage;
        }
        [HttpPost]
        [Route("stages")]
        public IHttpActionResult postStage(StageDTO pStage)
        {
            if (!ProcessManagmentData.insertStage(pStage))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpPut]
        [Route("stages")]
        public IHttpActionResult putStage(StageDTO pStage)
        {
            if (!ProcessManagmentData.updateStage(pStage))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpDelete]
        [Route("stages")]
        public IHttpActionResult deleteStage(string id_stage, string userLog)
        {
            if (!ProcessManagmentData.deleteStage(id_stage, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }
    }
}
