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
    class UsersProvider : AProvider
    {
        public UsersProvider(){}
        //--------------------------- Gets --------------------------------------
        public async Task<List<UserDTO>> getUsers()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<UserDTO> users = new List<UserDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.GetAsync("api/users/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    serializer.MaxJsonLength = Int32.MaxValue;
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.GetAsync("api/users/?user="+pUser).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    serializer.MaxJsonLength = Int32.MaxValue;
                    user = serializer.Deserialize<UserDTO>(result);
                }
                return user;
            }
        }
        public async Task<UserDTO> getUserbyID(string user_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                UserDTO user = new UserDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.GetAsync("api/users/?user_id=" + user_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    serializer.MaxJsonLength = Int32.MaxValue;
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.GetAsync("api/users/files/?user="+user).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    serializer.MaxJsonLength = Int32.MaxValue;
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
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
        public async Task<List<PersonalAttributeDTOmin>> getUserAttributesbyCategorie(string user_id, string categorie_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<PersonalAttributeDTOmin> userAttributes = new List<PersonalAttributeDTOmin>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.GetAsync("api/users/attributes/?user_id=" + user_id+ "&categorie_id=" + categorie_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    userAttributes = serializer.Deserialize<List<PersonalAttributeDTOmin>>(result);
                }
                return userAttributes;
            }
        }
        public async Task<List<CategorieDTO>> getUserCategories(string user_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<CategorieDTO> userCategories = new List<CategorieDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.GetAsync("api/users/attributes/categories/?user_id=" + user_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    userCategories = serializer.Deserialize<List<CategorieDTO>>(result);
                }
                return userCategories;
            }
        }
        public async Task<List<UserActivityDTO>> getUserActivity(string user_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<UserActivityDTO> userCategories = new List<UserActivityDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.GetAsync("api/users/activity/?user_id=" + user_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    userCategories = new JavaScriptSerializer().Deserialize<List<UserActivityDTO>>(result);
                }
                return userCategories;
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
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
                var serializer = new JavaScriptSerializer();
                serializer.MaxJsonLength = Int32.MaxValue;
                var userJson = serializer.Serialize(fileDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.PutAsync("api/Users/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> putdisableUser(UserDTO userDTO, string token)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(userDTO);
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/Account/disableUser", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> putUserPassword(UserPasswordDTO userPassword, string token)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(userPassword);
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/Account/ChangePassword", contentPost).Result;

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
                var serializer = new JavaScriptSerializer();
                serializer.MaxJsonLength = Int32.MaxValue;
                var userJson = serializer.Serialize(fileDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.PutAsync("api/Users/photo/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> putUserAttribute(PersonalAttributeDTOmin personalAttributeDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(personalAttributeDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.PutAsync("api/Users/attributes", contentPost).Result;
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
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.DeleteAsync("api/Users/role/?role_id=" + roleDTO.id_role+ "&user_id=" + roleDTO.user_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> deleteUserFile(FileDTO fileDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", getToken());
                HttpResponseMessage response = client.DeleteAsync("api/users/files/?id_file=" + fileDTO.id_file).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
    }
}
