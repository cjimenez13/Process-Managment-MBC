using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess
{
    public class RolesData
    {
        //----------------------------------------- Gets -----------------------------------------
        public static List<RoleDTO> getRoles()
        {
            List<RoleDTO> roles = new List<RoleDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_roles", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    RoleDTO rollDTO = new RoleDTO();
                    rollDTO.id_role = rdr["id_role"].ToString();
                    rollDTO.name = rdr["name"].ToString();
                    rollDTO.description = rdr["description"].ToString();
                    rollDTO.permissions = rdr["permissions"].ToString();
                    roles.Add(rollDTO);
                }
            };
            return roles;
        }
        //--------------------------------------------- Inserts --------------------------------------------
        public static string insertRoll(RoleDTO pRollDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_insert_role", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pRollDTO.name;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pRollDTO.description;

                command.Connection.Open();
                string result = null;
                try
                {
                    result = command.ExecuteScalar().ToString();
                }
                catch (Exception e)
                {

                }
                return result;
            };
        }
        public static bool deleteRole(string id_role)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_delete_role", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_role", SqlDbType.NVarChar);
                command.Parameters["@id_role"].Value = id_role;

                command.Connection.Open();
                string result = command.ExecuteScalar().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
    }
}
