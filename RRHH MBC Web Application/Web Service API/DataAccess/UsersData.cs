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
    class UsersData
    {
        //----------------------------------------- Gets -----------------------------------------
        public static List<CantonDTO> getCantones(int pID)
        {
            List<CantonDTO> provinces = new List<CantonDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_cantones", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@province_id", SqlDbType.TinyInt);
                command.Parameters["@province_id"].Value = pID;

                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    int id_canton = Int32.Parse(rdr["id_canton"].ToString());
                    string name = rdr["name"].ToString();
                    int province_id = Int32.Parse(rdr["province_id"].ToString());
                    string province_name = rdr["province_name"].ToString();

                    provinces.Add(new CantonDTO(id_canton, name, province_id, province_name));
                }
            };
            return provinces;
        }
        public static List<ProvinceDTO> getProvinces()
        {
            List<ProvinceDTO> provinces = new List<ProvinceDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_provinces", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    int id = Int32.Parse(rdr["id_province"].ToString());
                    string name = rdr["name"].ToString();
                    provinces.Add(new ProvinceDTO(id, name));
                }
            };
            return provinces;
        }
        public static List<UserDTO> getUsers()
        {
            List<UserDTO> users = new List<UserDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_users", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    UserDTO userDTO = new UserDTO();
                    userDTO.name = rdr["name"].ToString();
                    userDTO.sLastName = rdr["sLastName"].ToString();
                    userDTO.fLastName = rdr["fLastName"].ToString();
                    userDTO.email = rdr["email"].ToString();
                    userDTO.phoneNumber = rdr["phoneNumber"].ToString();
                    userDTO.canton_id = rdr["canton_id"].ToString();
                    userDTO.canton_name = rdr["canton_name"].ToString();
                    userDTO.province_name = rdr["province_name"].ToString();
                    userDTO.province_id = rdr["province_id"].ToString();
                    userDTO.direction = rdr["direction"].ToString();
                    userDTO.birthdate = rdr["birthdate"].ToString();
                    userDTO.userName = rdr["userName"].ToString();
                    userDTO.id = rdr["id"].ToString();
                    users.Add(userDTO);
                }
            };
            return users;
        }
        public static UserDTO getUser(string pUser)
        {
            UserDTO userDTO = new UserDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_user", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add("@user", SqlDbType.NVarChar);
                command.Parameters["@user"].Value = pUser;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    userDTO.name = rdr["name"].ToString();
                    userDTO.sLastName = rdr["sLastName"].ToString();
                    userDTO.fLastName = rdr["fLastName"].ToString();
                    userDTO.email = rdr["email"].ToString();
                    userDTO.phoneNumber = rdr["phoneNumber"].ToString();
                    userDTO.canton_id = rdr["canton_id"].ToString();
                    userDTO.canton_name = rdr["canton_name"].ToString();
                    userDTO.province_name = rdr["province_name"].ToString();
                    userDTO.province_id = rdr["province_id"].ToString();
                    userDTO.direction = rdr["direction"].ToString();
                    userDTO.birthdate = rdr["birthdate"].ToString();
                    userDTO.userName = rdr["userName"].ToString();
                    userDTO.id = rdr["id"].ToString();
                }
            };
            return userDTO;
        }


        //-------------------------------------------------- Creates -----------------------------------------------------------------
        public static bool createUser(UserDTO pUserDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_insert_user", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@userName", SqlDbType.NVarChar);
                command.Parameters["@userName"].Value = pUserDTO.userName;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pUserDTO.name;

                command.Parameters.Add("@fLastName", SqlDbType.NVarChar);
                command.Parameters["@fLastName"].Value = pUserDTO.fLastName;

                command.Parameters.Add("@sLastName", SqlDbType.NVarChar);
                command.Parameters["@sLastName"].Value = pUserDTO.sLastName;

                command.Parameters.Add("@email", SqlDbType.NVarChar);
                command.Parameters["@email"].Value = pUserDTO.email;

                command.Parameters.Add("@phoneNumber", SqlDbType.NVarChar);
                command.Parameters["@phoneNumber"].Value = pUserDTO.phoneNumber;

                command.Parameters.Add("@canton_id", SqlDbType.TinyInt);
                command.Parameters["@canton_id"].Value = pUserDTO.canton_id;

                command.Parameters.Add("@id", SqlDbType.NVarChar);
                command.Parameters["@id"].Value = pUserDTO.id;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
            };
            return false;
        }
        //-------------------------------------------------- updates ---------------------------------------------------------
        public static bool updateUser(UserDTO pUserDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_update_user", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@userName", SqlDbType.NVarChar);
                command.Parameters["@userName"].Value = pUserDTO.userName;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pUserDTO.name;

                command.Parameters.Add("@fLastName", SqlDbType.NVarChar);
                command.Parameters["@fLastName"].Value = pUserDTO.fLastName;

                command.Parameters.Add("@sLastName", SqlDbType.NVarChar);
                command.Parameters["@sLastName"].Value = pUserDTO.sLastName;

                command.Parameters.Add("@email", SqlDbType.NVarChar);
                command.Parameters["@email"].Value = pUserDTO.email;

                command.Parameters.Add("@phoneNumber", SqlDbType.NVarChar);
                command.Parameters["@phoneNumber"].Value = pUserDTO.phoneNumber;

                command.Parameters.Add("@canton_id", SqlDbType.TinyInt);
                command.Parameters["@canton_id"].Value = pUserDTO.canton_id;

                command.Parameters.Add("@id", SqlDbType.NVarChar);
                command.Parameters["@id"].Value = pUserDTO.id;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
            };
            return false;
        }
    }
}
