using DataTransferObjects;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Web.Script.Serialization;

namespace BeyondThemes.BeyondAdmin.Providers
{
    class UsersProvider
    {
        private string _BaseAddress = WebConfigurationManager.AppSettings["WebApi"];
        public UsersProvider()
        {

        }
        //--------------------------- Gets --------------------------------------
        //<Summary>Gets every enabled user available on the system
        public async Task<List<UserDTO>> getUsers()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<UserDTO> users = new List<UserDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/users/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    users = serializer.Deserialize<List<UserDTO>>(result);
                }
                return users;
            }
        }
        public async Task<UserDTO> getUser(string pUser)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                UserDTO user = new UserDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/users/?user="+pUser).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    user = serializer.Deserialize<UserDTO>(result);
                }
                return user;
            }
        }
        public async Task<List<ProvinceDTO>> getProvinces()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<ProvinceDTO> provinces = new List<ProvinceDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/users/provinces/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    provinces = serializer.Deserialize<List<ProvinceDTO>>(result);
                }
                return provinces;
            }
        }
        public async Task<List<CantonDTO>> getCantones(int pProvinceID)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<CantonDTO> cantones = new List<CantonDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/users/cantones/?province_id=" + pProvinceID.ToString()).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    cantones = serializer.Deserialize<List<CantonDTO>>(result);
                }
                return cantones;
            }
        }
        public async Task<List<FileDTO>> getFiles(string user)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<FileDTO> files = new List<FileDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/users/files/?user="+user).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    files = serializer.Deserialize<List<FileDTO>>(result);
                }
                return files;
            }
        }
        public async Task<List<RoleDTO>> getUserRoles(string user_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<RoleDTO> userRoles = new List<RoleDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/users/roles/?user_id=" + user_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    userRoles = serializer.Deserialize<List<RoleDTO>>(result);
                }
                return userRoles;
            }
        }
        //-------------------------------------- Posts -----------------------------------------------
        public async Task<bool> postUser(UserDTO userDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(userDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/Users/registerUser/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }

        public async Task<bool> postUserRole(RoleDTO roleDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(roleDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/Users/role/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }

        //---------------------------------- Puts ---------------------------------------------------
        public async Task<bool> putFile(FileDTO fileDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(fileDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/Users/file/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> putUser(UserDTO userDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(userDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/Users/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> putPhoto(FileDTO fileDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(fileDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/Users/photo/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteUsersRole(RoleDTO roleDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/users/role/?user_id=" + roleDTO.user_id+ "&role_id="+roleDTO.id_role).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
    }
}
