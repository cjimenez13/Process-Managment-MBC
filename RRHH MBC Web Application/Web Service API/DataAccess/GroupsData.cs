using DataTransferObjects;
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
    }
}
