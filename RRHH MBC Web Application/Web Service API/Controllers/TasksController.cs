using DataTransferObjects;
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
        public IHttpActionResult Post(TaskDTO taskDTO)
        {
            if (!TaskData.insertTask(taskDTO))
            {
                return BadRequest();
            }
            return Ok();
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
    }
}
