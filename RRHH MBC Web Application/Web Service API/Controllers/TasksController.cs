using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess.TaskData;

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
        [HttpGet]
        [Route("attributes")]
        public IEnumerable<AttributeDTO> getTaskAttributes(string id_task)
        {
            List<AttributeDTO> attributes = TaskData.getTaskAttributes(id_task);
            return attributes;
        }
        [HttpGet]
        [Route("questions/types")]
        public IEnumerable<QuestionTypeDTO> getFormQuestionTypes()
        {
            List<QuestionTypeDTO> questionTypes = TaskData.getQuestionTypes();
            return questionTypes;
        }
        [HttpGet]
        [Route("questions")]
        public IEnumerable<TaskQuestionDTO> getFormQuestions(string id_taskForm)
        {
            List<TaskQuestionDTO> questions = TaskData.getTaskQuestions(id_taskForm);
            return questions;
        }
        [HttpPost]
        [Route("questions")]
        public IHttpActionResult postFormQuestion(TaskQuestionDTO pQuestion)
        {
            if (!TaskData.insertQuestion(pQuestion))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        [Route("questions")]
        public IHttpActionResult putFormQuestion(TaskQuestionDTO pQuestionDTO)
        {
            if (!TaskData.updateQuestion(pQuestionDTO))
            {
                return BadRequest();
            }
            return Ok();
        }


        [HttpGet]
        [Route("forms")]
        public TaskFormDTO getTaskForm(string id_task)
        {
            TaskFormDTO taskForm = TaskData.getTaskForm(id_task);
            return taskForm;
        }

        [HttpPost]
        [Route("forms")]
        public IHttpActionResult postTaskForm(TaskFormDTO pTaskForm)
        {
            if (!TaskData.insertForm(pTaskForm))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        [Route("forms")]
        public IHttpActionResult putForm(TaskFormDTO pTaskForm)
        {
            if (!TaskData.updateForm(pTaskForm))
            { 
                return BadRequest();
            }
            return Ok();
        }

        [HttpGet]
        [Route("dataChanges")]
        public List<TaskChangeDTO> getTaskChanges(string id_task)
        {
            List<TaskChangeDTO> taskChanges = TaskChangesData.getTaskChanges(id_task);
            return taskChanges;
        }

        [HttpPost]
        [Route("dataChanges")]
        public IHttpActionResult postTaskChange(TaskChangeDTO pTaskChange)
        {
            if (!TaskChangesData.insertTaskChange(pTaskChange))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        [Route("dataChanges")]
        public IHttpActionResult putTaskChange(TaskChangeDTO pTaskChange)
        {
            if (!TaskChangesData.updateTaskChange(pTaskChange))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpDelete]
        [Route("dataChanges")]
        public IHttpActionResult deleteTaskChange(string id_taskChange, string userLog)
        {
            if (!TaskChangesData.deleteTask(id_taskChange, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpGet]
        [Route("operationTypes")]
        public List<OperationTypeDTO> getOperationTypes()
        {
            List<OperationTypeDTO> taskForm = TaskChangesData.getOperationTypes();
            return taskForm;
        }
    }
}
