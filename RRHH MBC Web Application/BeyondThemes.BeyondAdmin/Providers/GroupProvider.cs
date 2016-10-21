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
    public class GroupProvider : AProvider
    {
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

        public async Task<GroupDTO> getGroup(string id_group)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                GroupDTO group = new GroupDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/groups/?id_group="+id_group).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    group = serializer.Deserialize<GroupDTO>(result);
                }
                return group;
            }
        }
        public async Task<List<UserDTO>> getGroupMembers(string group_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<UserDTO> groupUsers = new List<UserDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/groups/members/?group_id="+ group_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    serializer.MaxJsonLength = Int32.MaxValue;
                    groupUsers = serializer.Deserialize<List<UserDTO>>(result);
                }
                return groupUsers;
            }
        }
        //-------------------------------------- Posts --------------------------------------------------


        /// <summary>
        /// // creates a new group
        /// </summary>
        /// <param name="groupDTO"></param>
        /// <returns>bool if it success</returns>
        public async Task<bool> postGroup(GroupDTO groupDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(groupDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/groups/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<List<GroupUserDTO>> postUsersGroups(List<GroupUserDTO> groupUserDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<GroupUserDTO> groupUsersDTOList = new List<GroupUserDTO>();
                var userJson = new JavaScriptSerializer().Serialize(groupUserDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/groups/members", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    groupUsersDTOList = serializer.Deserialize<List<GroupUserDTO>>(result);
                }
                return groupUsersDTOList;
            }
        }

        //-------------------------------------- Puts --------------------------------------------------
        public async Task<bool> putGroup(GroupDTO groupDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(groupDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/groups/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }

        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteGroup(GroupDTO groupDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/groups/?id_group=" + groupDTO.id_group).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> deleteGroupUser(GroupUserDTO groupUserDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/groups/members/?id_group=" + groupUserDTO.id_group+"&id_user="+groupUserDTO.user_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
    }
}
