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
    class TaskProvider : AProvider
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
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    tasks = serializer.Deserialize<List<TaskDTO>>(result);
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
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    task = serializer.Deserialize<TaskDTO>(result);
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
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    tasks = serializer.Deserialize<List<TaskTypeDTO>>(result);
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
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    task = serializer.Deserialize<TaskTypeDTO>(result);
                }
                return task;
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
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    tasks = serializer.Deserialize<List<TaskStateDTO>>(result);
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
                HttpResponseMessage response = client.GetAsync("api/tasks/taskStates?id_taskType=" + id_taskState).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    task = serializer.Deserialize<TaskStateDTO>(result);
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
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    responsables = serializer.Deserialize<List<TaskResponsableDTO>>(result);
                }
                return responsables;
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

        public async Task<bool> postResponsableUser(TaskResponsableDTO taskDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                string id_task = null;
                var userJson = new JavaScriptSerializer().Serialize(taskDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/responsables", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> postResponsableGroup(TaskResponsableDTO taskDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                string id_task = null;
                var userJson = new JavaScriptSerializer().Serialize(taskDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/tasks/responsables/group", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
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

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
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

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteTask(string id_task, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/?id_task=" + id_task + "&userLog=" + userLog).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> deleteTaskResponsable(string id_task, string user_id, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/tasks/responsables/?id_task=" + id_task + "&user_id="+ user_id+ "&userLog=" + userLog).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
    }
}
