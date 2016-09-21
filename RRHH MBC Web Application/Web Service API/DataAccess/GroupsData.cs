using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess
{
    class GroupsData
    {
        public static List<GroupDTO> getGroups()
        {
            List<GroupDTO> groups = new List<GroupDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_groups", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    GroupDTO GroupDTO = new GroupDTO();
                    GroupDTO.id_group = rdr["id_group"].ToString();
                    GroupDTO.groupName = rdr["groupName"].ToString();
                    GroupDTO.createdDate = rdr["createdDate"].ToString();
                    GroupDTO.isEnabled = rdr["isEnabled"].ToString();
                    groups.Add(GroupDTO);
                }
            };
            return groups;
        }
        public static GroupDTO getGroup(string id_group)
        {
            GroupDTO group = new GroupDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_group", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@group_id", SqlDbType.Int);
                command.Parameters["@group_id"].Value = id_group;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    group.id_group = rdr["id_group"].ToString();
                    group.groupName = rdr["groupName"].ToString();
                    group.createdDate = rdr["createdDate"].ToString();
                    group.isEnabled = rdr["isEnabled"].ToString();
                }
            };
            return group;
        }
        public static List<UserDTO> getGroupUsers(string group_id)
        {
            List<UserDTO> groupUsers = new List<UserDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_groupMembers", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@group_id", SqlDbType.Int);
                command.Parameters["@group_id"].Value = group_id;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    UserDTO userDTO = new UserDTO();
                    userDTO.name = rdr["name"].ToString();
                    userDTO.user_id = rdr["id_user"].ToString();
                    userDTO.fLastName = rdr["fLastName"].ToString();
                    userDTO.sLastName = rdr["sLastName"].ToString();
                    userDTO.email = rdr["email"].ToString();
                    userDTO.userName = rdr["userName"].ToString();
                    var photo = rdr["photoData"];
                        byte[] photoBytes = (byte[])rdr["photoData"];
                        userDTO.photoBase64 = Convert.ToBase64String(photoBytes);
                    groupUsers.Add(userDTO);
                }
            };
            return groupUsers;
        }

        //--------------------------------------------- Inserts --------------------------------------------
        public static bool insertGroup(GroupDTO pGroupDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_insert_group", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@groupName", SqlDbType.NVarChar);
                command.Parameters["@groupName"].Value = pGroupDTO.groupName;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }

        public static bool insertGroupUser(GroupUserDTO pUserGroupDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_insert_groupUser", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = pUserGroupDTO.user_id;
                command.Parameters.Add("@group_id", SqlDbType.Int);
                command.Parameters["@group_id"].Value = pUserGroupDTO.id_group;

                command.Connection.Open();
                try
                {
                    int result = command.ExecuteNonQuery();
                    if (result != 0)
                    {
                        return true;
                    }
                }
                catch (Exception e)
                {

                }
                return false;
            };
        }
        //--------------------------------------------- Updates --------------------------------------------
        public static bool updateGroup(GroupDTO pGroupDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_update_group", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_group", SqlDbType.Int);
                command.Parameters["@id_group"].Value = pGroupDTO.id_group;
                command.Parameters.Add("@groupName", SqlDbType.NVarChar);
                command.Parameters["@groupName"].Value = pGroupDTO.groupName;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
        //------------------------------------------------ Deletes ----------------------------------------------------
        public static bool deleteGroup(string id_group)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_delete_group", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_group", SqlDbType.Int);
                command.Parameters["@id_group"].Value = id_group;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool deleteGroupUser(string id_group, string id_user)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_delete_groupUser", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = id_user;

                command.Parameters.Add("@group_id", SqlDbType.Int);
                command.Parameters["@group_id"].Value = id_group;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }


    }
}
