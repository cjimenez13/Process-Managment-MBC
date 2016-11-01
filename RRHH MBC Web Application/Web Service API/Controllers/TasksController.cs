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
        public IEnumerable<TaskDTO> GetTasksbyUser(string user_id)
        {
            List<TaskDTO> tasks = TaskData.getTasksbyUser(user_id);
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
            List<QuestionTypeDTO> questionTypes = TaskFormData.getQuestionTypes();
            return questionTypes;
        }
        [HttpGet]
        [Route("questions")]
        public IEnumerable<TaskQuestionDTO> getFormQuestions(string id_taskForm)
        {
            List<TaskQuestionDTO> questions = TaskFormData.getTaskQuestions(id_taskForm);
            return questions;
        }
        [HttpPost]
        [Route("questions")]
        public IHttpActionResult postFormQuestion(TaskQuestionDTO pQuestion)
        {
            if (!TaskFormData.insertQuestion(pQuestion))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        [Route("questions")]
        public IHttpActionResult putFormQuestion(TaskQuestionDTO pQuestionDTO)
        {
            if (!TaskFormData.updateQuestion(pQuestionDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpGet]
        [Route("questionAnswers")]
        public IEnumerable<TaskQuestionAnswerDTO> getQuestionAnswers(string id_taskQuestion)
        {
            List<TaskQuestionAnswerDTO> questionAnswers = TaskFormData.getQuestionsAnswers(id_taskQuestion);
            return questionAnswers;
        }
        [HttpPost]
        [Route("questionAnswers")]
        public IHttpActionResult postQuestionAnswer(TaskQuestionAnswerDTO pQuestion)
        {
            if (!TaskFormData.insertQuestionAnswer(pQuestion))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpGet]
        [Route("forms")]
        public TaskFormDTO getTaskForm(string id_task)
        {
            TaskFormDTO taskForm = TaskFormData.getTaskForm(id_task);
            return taskForm;
        }

        [HttpPost]
        [Route("forms")]
        public IHttpActionResult postTaskForm(TaskFormDTO pTaskForm)
        {
            if (!TaskFormData.insertForm(pTaskForm))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        [Route("forms")]
        public IHttpActionResult putForm(TaskFormDTO pTaskForm)
        {
            if (!TaskFormData.updateForm(pTaskForm))
            { 
                return BadRequest();
            }
            return Ok();
        }

        [HttpGet]
        [Route("formUsers")]
        public List<TaskFormUserDTO> getFormUsers(string taskForm_id)
        {
            List<TaskFormUserDTO> formUsers = TaskFormData.getFormUsers(taskForm_id);
            return formUsers;
        }

        [HttpPost]
        [Route("formUsers")]
        public IEnumerable<TaskFormUserDTO> postFormUser(List<TaskFormUserDTO> formUsersDTO)
        {
            List<TaskFormUserDTO> insertedParticipants = new List<TaskFormUserDTO>();
            foreach (TaskFormUserDTO responsable in formUsersDTO)
            {
                try
                {
                    if (TaskFormData.insertFormUser(responsable))
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

        [HttpDelete]
        [Route("formUsers")]
        public IHttpActionResult deleteFormUser(string userLog, string user_id, string taskForm_id)
        {
            TaskFormUserDTO formUser = new TaskFormUserDTO();
            formUser.userLog = userLog;
            formUser.user_id = user_id;
            formUser.taskForm_id = taskForm_id;
            if (!TaskFormData.deleteFormUser(formUser))
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

        [HttpGet]
        [Route("files")]
        public List<FileTaskDTO> getTaskFiles(string id_task)
        {
            List<FileTaskDTO> taskFiles = TaskFilesData.getTaskFiles(id_task);
            return taskFiles;
        }

        [HttpPost]
        [Route("files")]
        public IHttpActionResult postTaskFile(FileTaskDTO pTaskFile)
        {
            if (!TaskFilesData.postFile(pTaskFile))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpDelete]
        [Route("files")]
        public IHttpActionResult deleteTaskFile(string id_taskFile, string userLog)
        {
            if (!TaskFilesData.deleteFile(id_taskFile, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpGet]
        [Route("notifications")]
        public List<TaskNotificationDTO> getTaskNotifications(string id_task)
        {
            List<TaskNotificationDTO> taskNotifications = TaskNotificationsData.getTaskNotifications(id_task);
            return taskNotifications;
        }

        [HttpPost]
        [Route("notifications")]
        public IHttpActionResult postTaskNotification(TaskNotificationDTO pTaskNotification)
        {
            if (!TaskNotificationsData.insertTaskNotification(pTaskNotification))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        [Route("notifications")]
        public IHttpActionResult putTaskNotification(TaskNotificationDTO pTaskNotification)
        {
            if (!TaskNotificationsData.updateTaskNotification(pTaskNotification))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpDelete]
        [Route("notifications")]
        public IHttpActionResult deleteTaskNotification(string id_taskNotification, string userLog)
        {
            if (!TaskNotificationsData.deleteTaskNotification(id_taskNotification, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPost]
        [Route("notificationTypes")]
        public IHttpActionResult postTaskNotificationType(TaskNotificationTypeDTO taskNotificationType)
        {
            if (!TaskNotificationsData.insertTaskNotificationType(taskNotificationType))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpDelete]
        [Route("notificationTypes")]
        public IHttpActionResult deleteTaskNotificationType(string id_taskNotification, string id_notificationType, string userLog)
        {
            if (!TaskNotificationsData.deleteTaskNotificationType(id_taskNotification, id_notificationType, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpGet]
        [Route("notificationsUsers")]
        public List<TaskNotificationUserDTO> getTaskNotificationsUsers(string id_notification)
        {
            List<TaskNotificationUserDTO> taskNotificationsUsers = TaskNotificationsData.getTaskNotificationUsers(id_notification);
            return taskNotificationsUsers;
        }

        [HttpPost]
        [Route("notificationsUsers")]
        public IEnumerable<TaskNotificationUserDTO> postTaskNotificationUser(List<TaskNotificationUserDTO> pTaskNotificationUser)
        {
            List<TaskNotificationUserDTO> insertedUsers = new List<TaskNotificationUserDTO>();
            foreach (TaskNotificationUserDTO responsable in pTaskNotificationUser)
            {
                try
                {
                    if (TaskNotificationsData.insertTaskNotificationUser(responsable))
                    {
                        insertedUsers.Add(responsable);
                    }
                }
                catch (Exception e)
                {
                    //e.Message;
                }
            }
            return insertedUsers;
        }

        [HttpDelete]
        [Route("notificationsUsers")]
        public IHttpActionResult deleteTaskNotificationUser(string taskNotification_id, string user_id, string userLog)
        {
            if (!TaskNotificationsData.deleteTaskNotificationUser(taskNotification_id, user_id, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }
    }
}
