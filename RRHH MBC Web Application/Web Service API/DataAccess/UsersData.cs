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
                SqlCommand command = new SqlCommand("usp_get_cantones", connection);
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
                SqlCommand command = new SqlCommand("usp_get_provinces", connection);
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
                SqlCommand command = new SqlCommand("usp_get_users", connection);
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
                    userDTO.user_id = rdr["id_user"].ToString();
                    byte[] photo = (byte[])rdr["photoData"];
                    userDTO.photoBase64 = Convert.ToBase64String(photo);
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
                SqlCommand command = new SqlCommand("usp_get_user", connection);
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
                    userDTO.password = rdr["password"].ToString();
                    userDTO.id = rdr["id"].ToString();
                    userDTO.user_id = rdr["id_user"].ToString();
                    byte[] photo = (byte[])rdr["photoData"];
                    userDTO.photoBase64 = Convert.ToBase64String(photo); 
                }
            };
            return userDTO;
        }
        public static UserDTO getUserbyID(string user_id)
        {
            UserDTO userDTO = new UserDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_user_byID", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add("@user_id", SqlDbType.NVarChar);
                command.Parameters["@user_id"].Value = user_id;
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
                    userDTO.user_id = rdr["id_user"].ToString();
                    byte[] photo = (byte[])rdr["photoData"];
                    userDTO.photoBase64 = Convert.ToBase64String(photo);
                }
            };
            return userDTO;
        }
        public static List<FileDTO> getUserFiles(string pUser)
        {
            List<FileDTO> fileDTOList = new List<FileDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_userFiles", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add("@user", SqlDbType.NVarChar);
                command.Parameters["@user"].Value = pUser;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    FileDTO fileDTO = new FileDTO();
                    fileDTO.name = rdr["name"].ToString();
                    fileDTO.description = rdr["description"].ToString();
                    fileDTO.createdDate = rdr["createdDate"].ToString();
                    fileDTO.id_file = rdr["id_file"].ToString();
                    fileDTO.fileType = rdr["fileType"].ToString();
                    fileDTO.fileName = rdr["fileName"].ToString();
                    byte[] file = (byte[])rdr["fileData"];
                    fileDTO.fileBase64 = Convert.ToBase64String(file);
                    fileDTOList.Add(fileDTO);
                }
            };
            return fileDTOList;
        }
        public static List<RoleDTO> getUserRoles(string pUser)
        {
            List<RoleDTO> roleDTOList = new List<RoleDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_userRoles", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = pUser;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    RoleDTO roleDTO = new RoleDTO();
                    roleDTO.id_role = rdr["id_role"].ToString();
                    roleDTO.name = rdr["name"].ToString();
                    roleDTO.description = rdr["description"].ToString();
                    roleDTO.user_id = rdr["user_id"].ToString();
                    roleDTOList.Add(roleDTO);
                }
            };
            return roleDTOList;
        }

        public static List<PersonalAttributeDTOmin> getUserAttributesbyCatgorie(string id_user, string id_categorie)
        {
            List<PersonalAttributeDTOmin> personaAttributeList = new List<PersonalAttributeDTOmin>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_userAttributes_byCategorie", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add("@id_user", SqlDbType.Int);
                command.Parameters["@id_user"].Value = id_user;
                command.Parameters.Add("@id_categorie", SqlDbType.Int);
                command.Parameters["@id_categorie"].Value = id_categorie;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    PersonalAttributeDTOmin personalAttribute = new PersonalAttributeDTOmin();
                    personalAttribute.attribute_id = rdr["id_attribute"].ToString();
                    personalAttribute.value = rdr["value"].ToString();
                    personalAttribute.type_id = rdr["type"].ToString();
                    personalAttribute.name = rdr["name"].ToString();
                    personaAttributeList.Add(personalAttribute);
                }
            };
            return personaAttributeList;
        }
        public static List<CategorieDTO> getUserCategories(string id_user)
        {
            List<CategorieDTO> personaAttributeList = new List<CategorieDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_userCategories", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add("@id_user", SqlDbType.Int);
                command.Parameters["@id_user"].Value = id_user;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    CategorieDTO categorie = new CategorieDTO();
                    categorie.id_categorie = rdr["id_categorie"].ToString();
                    categorie.name = rdr["name"].ToString();
                    categorie.description = rdr["description"].ToString();
                    categorie.isEnabled = rdr["isEnabled"].ToString();
                    personaAttributeList.Add(categorie);
                }
            };
            return personaAttributeList;
        }

        //-------------------------------------------------- Creates -----------------------------------------------------------------
        public static bool createUser(UserDTO pUserDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_user", connection);
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

                command.Parameters.Add("@birthdate", SqlDbType.NVarChar);
                command.Parameters["@birthdate"].Value = pUserDTO.birthdate;

                command.Parameters.Add("@direction", SqlDbType.NVarChar);
                command.Parameters["@direction"].Value = pUserDTO.direction;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
            };
            return false;
        }
        public static bool postFile(FileDTO pFileDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_userFile", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@user_id", SqlDbType.NVarChar);
                command.Parameters["@user_id"].Value = pFileDTO.user;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pFileDTO.name;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pFileDTO.description;

                command.Parameters.Add("@fileData", SqlDbType.VarBinary);
                command.Parameters["@fileData"].Value = pFileDTO.fileData;

                command.Parameters.Add("@fileType", SqlDbType.NVarChar);
                command.Parameters["@fileType"].Value = pFileDTO.fileType;

                command.Parameters.Add("@fileName", SqlDbType.NVarChar);
                command.Parameters["@fileName"].Value = pFileDTO.fileName;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
            };
            return false;
        }
        public static bool insertUserRoll(RoleDTO pRollDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_userRole", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = pRollDTO.user_id;

                command.Parameters.Add("@role_id", SqlDbType.Int);
                command.Parameters["@role_id"].Value = pRollDTO.id_role;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }

        //-------------------------------------------------- updates ---------------------------------------------------------
        public static bool updateUser(UserDTO pUserDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_user", connection);
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

                command.Parameters.Add("@user", SqlDbType.NVarChar);
                command.Parameters["@user"].Value = pUserDTO.userName!=""? pUserDTO.userName : pUserDTO.email;

                command.Parameters.Add("@id", SqlDbType.NVarChar);
                command.Parameters["@id"].Value = pUserDTO.id;

                command.Parameters.Add("@birthdate", SqlDbType.NVarChar);
                command.Parameters["@birthdate"].Value = pUserDTO.birthdate;

                command.Parameters.Add("@direction", SqlDbType.NVarChar);
                command.Parameters["@direction"].Value = pUserDTO.direction;

                command.Parameters.Add("@telegram_id", SqlDbType.NVarChar);
                command.Parameters["@telegram_id"].Value = pUserDTO.telegram_id;

                command.Parameters.Add("@telegram_user", SqlDbType.NVarChar);
                command.Parameters["@telegram_user"].Value = pUserDTO.telegram_user;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
            };
            return false;
        }
        public static bool updatePhoto(FileDTO pFileDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_userPhoto", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@user", SqlDbType.NVarChar);
                command.Parameters["@user"].Value = pFileDTO.user;

                command.Parameters.Add("@photoData", SqlDbType.VarBinary);
                command.Parameters["@photoData"].Value = pFileDTO.fileData;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
            };
            return false;
        }
        public static bool updateUserAttribute(PersonalAttributeDTOmin pUserAttribute)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_userAttribute", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_attribute", SqlDbType.Int);
                command.Parameters["@id_attribute"].Value = pUserAttribute.attribute_id;

                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pUserAttribute.value;

                command.Parameters.Add("@id_user", SqlDbType.Int);
                command.Parameters["@id_user"].Value = pUserAttribute.user_id;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pUserAttribute.userLog;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
            };
            return false;
        }

        public static bool updateUserPassword(UserPasswordDTO pUserPassword)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_userPasssword", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@password", SqlDbType.NVarChar);
                command.Parameters["@password"].Value = pUserPassword.password;

                command.Parameters.Add("@id_user", SqlDbType.Int);
                command.Parameters["@id_user"].Value = pUserPassword.id_user;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pUserPassword.userLog;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
            };
            return false;
        }
        //------------------------------------------------ Deletes ----------------------------------------------------
        public static bool deleteUserRole(string role_id, string user_id)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_userRole", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@role_id", SqlDbType.Int);
                command.Parameters["@role_id"].Value = role_id;

                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = user_id;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool deleteFile(string id_file)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_userFile", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_file", SqlDbType.Int);
                command.Parameters["@id_file"].Value = id_file;

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
