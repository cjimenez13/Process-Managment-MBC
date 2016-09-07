using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Web.Script.Serialization;

namespace BeyondThemes.BeyondAdmin.Providers
{
    class RoleProvider
    {
        private string _BaseAddress = WebConfigurationManager.AppSettings["WebApi"];
        public RoleProvider() { }
        //--------------------------- Gets --------------------------------------
        //<Summary>Gets every enabled user available on the system
        public async Task<List<RoleDTO>> getRoles()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<RoleDTO> roles = new List<RoleDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/roles/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    roles = serializer.Deserialize<List<RoleDTO>>(result);
                }
                return roles;
            }
        }

        //-------------------------------------- Posts -----------------------------------------------
        public async Task<RoleDTO> postRole(RoleDTO rollDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(rollDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/roles/", contentPost).Result;

                RoleDTO newRole = new RoleDTO();
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    newRole = serializer.Deserialize<RoleDTO>(result);
                }
                return newRole;
            }
        }

        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteRole(RoleDTO roleDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/Roles/?id_role="+ roleDTO.id_role).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
    }
}
