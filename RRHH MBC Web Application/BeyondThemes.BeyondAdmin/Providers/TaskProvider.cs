using System;
using System.Collections.Generic;
using DataTransferObjects;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace BeyondThemes.BeyondAdmin.Providers
{
    public class TaskProvider : AProvider
    {
        public async Task<List<TaskDTO>> getTasks(string id_stage)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskDTO> tasks = new List<TaskDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/?id_stage="+id_stage).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    tasks = new JavaScriptSerializer().Deserialize<List<TaskDTO>>(result);
                }
                return tasks;
            }
        }
        public async Task<TaskDTO> getTask(string id_task)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                TaskDTO task = new TaskDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/?id_task=" + id_task).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    task = new JavaScriptSerializer().Deserialize<TaskDTO>(result);
                }
                return task;
            }
        }
        public async Task<List<TaskTypeDTO>> getTaskTypes()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskTypeDTO> tasks = new List<TaskTypeDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/taskTypes").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    tasks = new JavaScriptSerializer().Deserialize<List<TaskTypeDTO>>(result);
                }
                return tasks;
            }
        }
        public async Task<TaskTypeDTO> getTaskType(string id_taskType)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                TaskTypeDTO task = new TaskTypeDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/taskTypes?id_taskType=" + id_taskType).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    task = new JavaScriptSerializer().Deserialize<TaskTypeDTO>(result);
                }
                return task;
            }
        }
        public async Task<List<ParticipantDTO>> getTaskParticipants(string id_task)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<ParticipantDTO> taskParticipants = new List<ParticipantDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/participants?id_task="+id_task).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    taskParticipants = new JavaScriptSerializer().Deserialize<List<ParticipantDTO>>(result);
                }
                return taskParticipants;
            }
        }
        public async Task<List<TaskStateDTO>> getTaskStates()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskStateDTO> tasks = new List<TaskStateDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/taskStates").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    tasks = new JavaScriptSerializer().Deserialize<List<TaskStateDTO>>(result);
                }
                return tasks;
            }
        }
        public async Task<TaskStateDTO> getTaskState(string id_taskState)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                TaskStateDTO task = new TaskStateDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/taskStates?id_taskState=" + id_taskState).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    task = new JavaScriptSerializer().Deserialize<TaskStateDTO>(result);
                }
                return task;
            }
        }
        public async Task<List<TaskResponsableDTO>> getTaskResponsables(string id_task)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskResponsableDTO> responsables = new List<TaskResponsableDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/responsables?id_task=" + id_task).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    responsables = new JavaScriptSerializer().Deserialize<List<TaskResponsableDTO>>(result);
                }
                return responsables;
            }
        }
        public async Task<List<TaskQuestionDTO>> getFormQuestions(string id_taskForm)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskQuestionDTO> questions = new List<TaskQuestionDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/questions?id_taskForm=" + id_taskForm).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    questions = new JavaScriptSerializer().Deserialize<List<TaskQuestionDTO>>(result);
                }
                return questions;
            }
        }
        public async Task<TaskFormDTO> getTaskForm(string id_task)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                TaskFormDTO form = new TaskFormDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/forms?id_task=" + id_task).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    form = new JavaScriptSerializer().Deserialize<TaskFormDTO>(result);
                }
                return form;
            }
        }
        public async Task<List<QuestionTypeDTO>> getQuestionTypes()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<QuestionTypeDTO> form = new List<QuestionTypeDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/questions/types").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    form = new JavaScriptSerializer().Deserialize<List<QuestionTypeDTO>>(result);
                }
                return form;
            }
        }
        public async Task<List<AttributeDTO>> getTaskAttributes(string id_task)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<AttributeDTO> attributes = new List<AttributeDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/attributes?id_task="+ id_task).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    attributes = new JavaScriptSerializer().Deserialize<List<AttributeDTO>>(result);
                }
                return attributes;
            }
        }
        public async Task<List<TaskChangeDTO>> getTaskChanges(string id_task)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskChangeDTO> changes = new List<TaskChangeDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/dataChanges?id_task=" + id_task).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    changes = new JavaScriptSerializer().Deserialize<List<TaskChangeDTO>>(result);
                }
                return changes;
            }
        }
        public async Task<List<OperationTypeDTO>> getOperationTypes()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<OperationTypeDTO> operationTypes = new List<OperationTypeDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/operationTypes").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    operationTypes = new JavaScriptSerializer().Deserialize<List<OperationTypeDTO>>(result);
                }
                return operationTypes;
            }
        }

        public async Task<List<FileTaskDTO>> getTaskFiles(string id_task)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<FileTaskDTO> operationTypes = new List<FileTaskDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/files?id_task="+id_task).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    operationTypes = new JavaScriptSerializer().Deserialize<List<FileTaskDTO>>(result);
                }
                return operationTypes;
            }
        }
        public async Task<List<TaskNotificationDTO>> getTaskNotifications(string id_task)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskNotificationDTO> taskNotifications = new List<TaskNotificationDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/notifications?id_task=" + id_task).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    taskNotifications = new JavaScriptSerializer().Deserialize<List<TaskNotificationDTO>>(result);
                }
                return taskNotifications;
            }
        }
        public async Task<List<TaskNotificationUserDTO>> getTaskNotificationUsers(string id_notification)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskNotificationUserDTO> taskNotificationsUsers = new List<TaskNotificationUserDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/tasks/notificationsUsers?id_notification=" + id_notification).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    taskNotificationsUsers = new JavaScriptSerializer().Deserialize<List<TaskNotificationUserDTO>>(result);
                }
                return taskNotificationsUsers;
            }
        }
        //-------------------------------------- Posts --------------------------------------------------

        public async Task<string> postTask(TaskDTO taskDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                string id_task = null;
                var userJson = new JavaScriptSerializer().Serialize(taskDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    id_task = await response.Content.ReadAsStringAsync();
                }
                return id_task;
            }
        }

        public async Task<List<TaskResponsableDTO>> postResponsableUser(List<TaskResponsableDTO> taskResponsablesDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskResponsableDTO> insertedResponsables = new List<TaskResponsableDTO>();
                var userJson = new JavaScriptSerializer().Serialize(taskResponsablesDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/responsables", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    insertedResponsables = new JavaScriptSerializer().Deserialize<List<TaskResponsableDTO>>(result);
                }
                return insertedResponsables;
            }
        }
        public async Task<bool> postResponsableGroup(TaskResponsableDTO taskDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/responsables/group", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> postFormQuestion(TaskQuestionDTO questionDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(questionDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/questions", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> postTaskForm(TaskFormDTO formDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(formDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/forms", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> postTaskChange(TaskChangeDTO taskChamgeDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskChamgeDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/dataChanges", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> postTaskFile(FileTaskDTO taskFileDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskFileDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/files", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> postTaskNotification(TaskNotificationDTO taskNotificationDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskNotificationDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/notifications", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<List<TaskNotificationUserDTO>> postTaskNotificationUser(List<TaskNotificationUserDTO> taskNotificationUserDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TaskNotificationUserDTO> insertedUsers = new List<TaskNotificationUserDTO>();
                var userJson = new JavaScriptSerializer().Serialize(taskNotificationUserDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/notificationsUsers", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    insertedUsers = new JavaScriptSerializer().Deserialize<List<TaskNotificationUserDTO>>(result);
                }
                return insertedUsers;
            }
        }
        //-------------------------------------- Puts --------------------------------------------------
        public async Task<bool> putTask(TaskDTO taskDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/tasks/", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }

        public async Task<bool> putTaskResponsable(TaskResponsableDTO taskResponsable)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskResponsable);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/tasks/responsables", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> putFormQuestion(TaskQuestionDTO taskFormQuestion)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskFormQuestion);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/tasks/questions", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> putTaskForm(TaskFormDTO taskFormDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskFormDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/tasks/forms", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> putTaskChange(TaskChangeDTO taskChangeDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskChangeDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/tasks/dataChanges", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> putTaskNotification(TaskChangeDTO taskNotificationDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(taskNotificationDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/tasks/notifications", contentPost).Result;
                return response.IsSuccessStatusCode;
            }
        }


        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteTask(string id_task, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/?id_task=" + id_task + "&userLog=" + userLog).Result;
                return response.IsSuccessStatusCode;

            }
        }
        public async Task<bool> deleteTaskResponsable(string id_task, string user_id, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/responsables/?id_task=" + id_task + "&user_id="+ user_id+ "&userLog=" + userLog).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> deleteFormQuestion(string id_taskQuestion, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/questions/?id_taskQuestion=" + id_taskQuestion + "&userLog=" + userLog).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> deleteTaskChange(string id_taskChange, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/dataChanges/?id_taskChange=" + id_taskChange + "&userLog=" + userLog).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> deleteTaskFile(string id_taskFile, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/files/?id_taskFile=" + id_taskFile + "&userLog=" + userLog).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> deleteTaskNotification(string id_taskNotification, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/notifications/?id_taskNotification=" + id_taskNotification + "&userLog=" + userLog).Result;
                return response.IsSuccessStatusCode;
            }
        }
        public async Task<bool> deleteTaskNotificationUser(string taskNotification_id, string user_id, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/notificationsUsers/?taskNotification_id=" + taskNotification_id + "&user_id="+user_id+"&userLog=" + userLog).Result;
                return response.IsSuccessStatusCode;
            }
        }
    }
}
