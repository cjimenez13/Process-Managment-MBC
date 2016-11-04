using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    class ProcessProvider : ProcessManagmentProvider
    {

        public async Task<List<ProcessDTO>> getProcesses()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<ProcessDTO> processes = new List<ProcessDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/process/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    processes = serializer.Deserialize<List<ProcessDTO>>(result);
                }
                return processes;
            }
        }
        public async Task<List<ProcessDTO>> getProcessesbyUser(string user_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<ProcessDTO> processes = new List<ProcessDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/process/?user_id="+user_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    processes = serializer.Deserialize<List<ProcessDTO>>(result);
                }
                return processes;
            }
        }

        public async Task<ProcessDTO> getProcess(string id_process)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                ProcessDTO process = new ProcessDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/process/?id_process=" + id_process).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    process = serializer.Deserialize<ProcessDTO>(result);
                }
                return process;
            }
        }
        public async Task<List<ProcessStateDTO>> getProcessStates()
        {
            var user_id = System.Web.HttpContext.Current.Request.Cookies["user_id"].Value;
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<ProcessStateDTO> process = new List<ProcessStateDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/process/states").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    process = new JavaScriptSerializer().Deserialize<List<ProcessStateDTO>>(result);
                }
                return process;
            }
        }
        //-------------------------------------- Posts --------------------------------------------------

        public async Task<string> postProcess(ProcessDTO processDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(processDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/process/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return new JavaScriptSerializer().Deserialize<String>(await response.Content.ReadAsStringAsync());
                }
                return "-1";
            }
        }
        //-------------------------------------- Puts --------------------------------------------------
        public async Task<bool> putProcess(ProcessDTO processDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(processDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/process/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }

        public async Task<bool> bifurcateProcess(BifurcateProcessDTO bifurcateProcessDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(bifurcateProcessDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/process/bifurcate", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }


        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteProcess(string id_process, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/process/?id_process=" + id_process + "&userLog=" + userLog).Result;
                return response.IsSuccessStatusCode;
            }
        }
    }
}
