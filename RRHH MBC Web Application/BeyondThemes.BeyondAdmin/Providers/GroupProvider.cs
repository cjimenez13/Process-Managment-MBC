using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Web.Script.Serialization;

namespace BeyondThemes.BeyondAdmin.Providers
{
    class GroupProvider
    {
        private string _BaseAddress = WebConfigurationManager.AppSettings["WebApi"];
        public async Task<List<GroupDTO>> getGroups()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<GroupDTO> groups = new List<GroupDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/groups/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    groups = serializer.Deserialize<List<GroupDTO>>(result);
                }
                return groups;
            }
        }
    }
}
