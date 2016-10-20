using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace BeyondThemes.BeyondAdmin.Providers
{
    public class ProcessManagmentProvider : AProvider
    {
        public async Task<List<ParticipantDTO>> getParticipants(string id_process)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<ParticipantDTO> participants = new List<ParticipantDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/processManagment/participants/?id_process=" + id_process).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    participants = serializer.Deserialize<List<ParticipantDTO>>(result);
                }
                return participants;
            }
        }
        public async Task<List<StageDTO>> getStages(string id_process)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<StageDTO> stages = new List<StageDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/processManagment/stages/?id_process=" + id_process).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    stages = serializer.Deserialize<List<StageDTO>>(result);
                }
                return stages;
            }
        }
        public async Task<StageDTO> getStage(string id_stage)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                StageDTO stage = new StageDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/processManagment/stages/?id_stage=" + id_stage).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    stage = serializer.Deserialize<StageDTO>(result);
                }
                return stage;
            }
        }
        //-------------------------------------- Posts --------------------------------------------------
        public async Task<List<ParticipantDTO>> postParticipants(List<ParticipantDTO> pParticipantDTO)
        {
            using (var client = new HttpClient())
            {
                List<ParticipantDTO> insertedParticipants = new List<ParticipantDTO>();
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pParticipantDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/processManagment/participants/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    insertedParticipants = serializer.Deserialize<List<ParticipantDTO>>(result);
                }
                return insertedParticipants;
            }
        }
        public async Task<List<ParticipantDTO>> postGroups(List<ParticipantDTO> pParticipantDTO)
        {
            using (var client = new HttpClient())
            {
                List<ParticipantDTO> insertedParticipants = new List<ParticipantDTO>();
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pParticipantDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/processManagment/groups/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    insertedParticipants = serializer.Deserialize<List<ParticipantDTO>>(result);
                }
                return insertedParticipants;
            }
        }
        public async Task<bool> postStage(StageDTO pParticipantDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pParticipantDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/processManagment/stages/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        //-------------------------------------- Puts -----------------------------------------------

        public async Task<bool> putStage(StageDTO pParticipantDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pParticipantDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/processManagment/stages/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteParticipant(string user_id, string id_process, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/processManagment/participants/?user_id=" + user_id+"&id_process="+id_process+"&userLog="+userLog).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> deleteStage(string id_stage, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/processManagment/stages/?id_stage=" + id_stage + "&userLog=" + userLog).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }

    }
}
