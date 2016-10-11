using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/tasks")]
    public class TasksController :ApiController
    {
        [HttpGet]
        public IEnumerable<TaskDTO> Get(string id_stage)
        {
            List<TaskDTO> tasks = TaskData.getTasks(id_stage);
            return tasks;
        }
        [HttpGet]
        public TaskDTO GetTask(string id_task)
        {
            TaskDTO task = TaskData.getTask(id_task);
            return task;
        }
        [HttpPost]
        public string Post(TaskDTO taskDTO)
        {
            string result = TaskData.insertTask(taskDTO);
            return result;
        }

        [HttpPut]
        public IHttpActionResult Put(TaskDTO taskDTO)
        {
            if (!TaskData.updateTask(taskDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpDelete]
        public IHttpActionResult Delete(string id_task, string userLog)
        {
            if (!TaskData.deleteTask(id_task, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpGet]
        [Route("taskTypes")]
        public IEnumerable<TaskTypeDTO> getTaskTypes()
        {
            List<TaskTypeDTO> taskTypes = TaskData.getTaskTypes();
            return taskTypes;
        }
        [HttpGet]
        [Route("taskTypes")]
        public TaskTypeDTO getTaskType(string id_taskType)
        {
            TaskTypeDTO taskType = TaskData.getTaskType(id_taskType);
            return taskType;
        }

        [HttpGet]
        [Route("taskStates")]
        public IEnumerable<TaskStateDTO> getTaskStates()
        {
            List<TaskStateDTO> taskStates = TaskData.getTaskStates();
            return taskStates;
        }
        [HttpGet]
        [Route("taskStates")]
        public TaskStateDTO getTaskState(string id_taskState)
        {
            TaskStateDTO taskState = TaskData.getTaskState(id_taskState);
            return taskState;
        }
        [HttpGet]
        [Route("participants")]
        public IEnumerable<ParticipantDTO> getTaskParticipants(string id_task)
        {
            List<ParticipantDTO> taskParticipants = TaskData.getTaskParticipants(id_task);
            return taskParticipants;
        }
        [HttpGet]
        [Route("responsables")]
        public IEnumerable<TaskResponsableDTO> getTaskResponsables(string id_task)
        {
            List<TaskResponsableDTO> taskTypes = TaskData.getTaskResponsables(id_task);
            return taskTypes;
        }

        [HttpPost]
        [Route("responsables")]
        public IEnumerable<TaskResponsableDTO> postTaskResponsablesUser(List<TaskResponsableDTO> responsableDTO)
        {
            List<TaskResponsableDTO> insertedParticipants = new List<TaskResponsableDTO>();
            foreach (TaskResponsableDTO responsable in responsableDTO)
            {
                try
                {
                    if (TaskData.insertResponsableUser(responsable))
                    {
                        insertedParticipants.Add(responsable);
                    }
                }
                catch (Exception e)
                {
                    //e.Message;
                }
            }
            return insertedParticipants;
        }

        [HttpPost]
        [Route("responsables/group")]
        public IHttpActionResult postTaskResponsablesGroup(TaskResponsableDTO responsableDTO)
        {
            if (!TaskData.insertResponsableGroup(responsableDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        [Route("responsables")]
        public IHttpActionResult putTaskResponsable(TaskResponsableDTO responsableDTO)
        {
            if (!TaskData.updateResponsableTask(responsableDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpDelete]
        [Route("responsables")]
        public IHttpActionResult deleteTaskResponsable(string id_task, string user_id, string userLog)
        {
            if (!TaskData.deleteResponsable(id_task, user_id, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }
    }
}
