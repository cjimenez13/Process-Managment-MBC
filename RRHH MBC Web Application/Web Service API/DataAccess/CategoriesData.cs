using DataTransferObjects;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess
{
    class CategoriesData
    {
        //----------------------------------------------- Gets ------------------------------------------------
        public static List<CategorieDTO> getCategories()
        {
            List<CategorieDTO> categories = new List<CategorieDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_categories", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    CategorieDTO categorieDTO = new CategorieDTO();
                    categorieDTO.id_categorie = rdr["id_categorie"].ToString();
                    categorieDTO.name = rdr["name"].ToString();
                    categorieDTO.description = rdr["description"].ToString();
                    categorieDTO.createdBy_id = rdr["createdBy_id"].ToString();
                    categorieDTO.createdBy_name = rdr["createdBy_name"].ToString();
                    categorieDTO.createdDate = rdr["createdDate"].ToString();
                    categorieDTO.isEnabled = rdr["isEnabled"].ToString();
                    categories.Add(categorieDTO);
                }
            };
            return categories;
        }
        public static CategorieDTO getCategorie(string id_categorie)
        {
            CategorieDTO categorieDTO = new CategorieDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_categorie", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_categorie", SqlDbType.Int);
                command.Parameters["@id_categorie"].Value = id_categorie;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    categorieDTO.id_categorie = rdr["id_categorie"].ToString();
                    categorieDTO.name = rdr["name"].ToString();
                    categorieDTO.description = rdr["description"].ToString();
                    categorieDTO.createdBy_id = rdr["createdBy_id"].ToString();
                    categorieDTO.createdBy_name = rdr["createdBy_name"].ToString();
                    categorieDTO.createdDate = rdr["createdDate"].ToString();
                    categorieDTO.isEnabled = rdr["isEnabled"].ToString();
                }
            };
            return categorieDTO;
        }

        public static List<AttributeTypeDTO> getAttributeTypes()
        {
            List<AttributeTypeDTO> atributeTypesDTO = new List<AttributeTypeDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_attributeTypes", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    AttributeTypeDTO attributeTypeDTO = new AttributeTypeDTO();
                    attributeTypeDTO.id_type = rdr["id_type"].ToString();
                    attributeTypeDTO.type = rdr["type"].ToString();
                    attributeTypeDTO.reg_expr = rdr["reg_expr"].ToString();
                    atributeTypesDTO.Add(attributeTypeDTO);
                }
            };
            return atributeTypesDTO;
        }
        public static AttributeTypeDTO getAttributeTypes(string id_type)
        {
            AttributeTypeDTO atributeTypeDTO = new AttributeTypeDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_attributeType", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_type", SqlDbType.Int);
                command.Parameters["@id_type"].Value = id_type;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    atributeTypeDTO.id_type = rdr["id_type"].ToString();
                    atributeTypeDTO.type = rdr["type"].ToString();
                    atributeTypeDTO.reg_expr = rdr["reg_expr"].ToString();
                }
            };
            return atributeTypeDTO;
        }


        public static List<GeneralAttributeDTO> getGeneralAttributes(string categorie_id)
        {
            List<GeneralAttributeDTO> generalAttributesDTO = new List<GeneralAttributeDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_generalAttributes", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@categorie_id", SqlDbType.Int);
                command.Parameters["@categorie_id"].Value = categorie_id;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    GeneralAttributeDTO generalAttributeDTO = new GeneralAttributeDTO();
                    generalAttributeDTO.id_attribute = rdr["id_attribute"].ToString();
                    generalAttributeDTO.categorie_id = rdr["categorie_id"].ToString();
                    generalAttributeDTO.name = rdr["name"].ToString();
                    generalAttributeDTO.type_id = rdr["type"].ToString();
                    generalAttributeDTO.value = rdr["value"].ToString();
                    generalAttributeDTO.isEnabled = rdr["isEnabled"].ToString();
                    generalAttributeDTO.createdBy = rdr["createdBy"].ToString();
                    generalAttributeDTO.createdDate = rdr["createdDate"].ToString();
                    generalAttributesDTO.Add(generalAttributeDTO);
                }
            };
            return generalAttributesDTO;
        }
        public static GeneralAttributeDTO getGeneralAttribute(string id_attribute)
        {
            GeneralAttributeDTO generalAttributeDTO = new GeneralAttributeDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_generalAttribute", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_attribute", SqlDbType.Int);
                command.Parameters["@id_attribute"].Value = id_attribute;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    generalAttributeDTO.id_attribute = rdr["id_attribute"].ToString();
                    generalAttributeDTO.categorie_id = rdr["categorie_id"].ToString();
                    generalAttributeDTO.name = rdr["name"].ToString();
                    generalAttributeDTO.type_id = rdr["type"].ToString();
                    generalAttributeDTO.value = rdr["value"].ToString();
                    generalAttributeDTO.isEnabled = rdr["isEnabled"].ToString();
                    generalAttributeDTO.createdBy = rdr["createdBy"].ToString();
                    generalAttributeDTO.createdDate = rdr["createdDate"].ToString();
                }
            };
            return generalAttributeDTO;
        }
        //-- Personal attributes

        public static List<PersonalAttributeDTO> getPersonalAttributes(string categorie_id)
        {
            List<PersonalAttributeDTO> personalAttributesDTO = new List<PersonalAttributeDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_personalAttributes", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@categorie_id", SqlDbType.Int);
                command.Parameters["@categorie_id"].Value = categorie_id;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    PersonalAttributeDTO personalAttributeDTO = new PersonalAttributeDTO();
                    personalAttributeDTO.id_attribute = rdr["id_attribute"].ToString();
                    personalAttributeDTO.categorie_id = rdr["categorie_id"].ToString();
                    personalAttributeDTO.name = rdr["name"].ToString();
                    personalAttributeDTO.type_id = rdr["type"].ToString();
                    personalAttributeDTO.value = rdr["value"].ToString();
                    personalAttributeDTO.isEnabled = rdr["isEnabled"].ToString();
                    personalAttributeDTO.createdBy = rdr["createdBy"].ToString();
                    personalAttributeDTO.createdDate = rdr["createdDate"].ToString();
                    personalAttributesDTO.Add(personalAttributeDTO);
                }
            };
            return personalAttributesDTO;
        }
        public static PersonalAttributeDTO getPersonalAttribute(string id_attribute)
        {
            PersonalAttributeDTO personalAttributeDTO = new PersonalAttributeDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_personalAttribute", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_attribute", SqlDbType.Int);
                command.Parameters["@id_attribute"].Value = id_attribute;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    personalAttributeDTO.id_attribute = rdr["id_attribute"].ToString();
                    personalAttributeDTO.categorie_id = rdr["categorie_id"].ToString();
                    personalAttributeDTO.name = rdr["name"].ToString();
                    personalAttributeDTO.type_id = rdr["type"].ToString();
                    personalAttributeDTO.value = rdr["value"].ToString();
                    personalAttributeDTO.isEnabled = rdr["isEnabled"].ToString();
                    personalAttributeDTO.createdBy = rdr["createdBy"].ToString();
                    personalAttributeDTO.createdDate = rdr["createdDate"].ToString();
                }
            };
            return personalAttributeDTO;
        }
        public static List<AttributeListDTO> getAttributesList(string id_attribute)
        {
            List<AttributeListDTO> AttributesListDTO = new List<AttributeListDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_AttributesList", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_attribute", SqlDbType.Int);
                command.Parameters["@id_attribute"].Value = id_attribute;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    AttributeListDTO attributeListDTO = new AttributeListDTO();
                    attributeListDTO.id_attributeValue = rdr["id_attributeValue"].ToString();
                    attributeListDTO.attribute_id = rdr["attribute_id"].ToString();
                    attributeListDTO.name = rdr["name"].ToString();
                    attributeListDTO.type_id = rdr["type_id"].ToString();
                    attributeListDTO.value = rdr["value"].ToString();
                    attributeListDTO.isEnabled = rdr["isEnabled"].ToString();
                    attributeListDTO.createdBy = rdr["createdBy"].ToString();
                    attributeListDTO.createdDate = rdr["createdDate"].ToString();
                    AttributesListDTO.Add(attributeListDTO);
                }
            };
            return AttributesListDTO;
        }
        public static AttributeListDTO getAttributeList(string id_attributeValue)
        {
            AttributeListDTO attributeListDTO = new AttributeListDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_AttributeList", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_attributeValue", SqlDbType.Int);
                command.Parameters["@id_attributeValue"].Value = id_attributeValue;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    attributeListDTO.id_attributeValue = rdr["id_attributeValue"].ToString();
                    attributeListDTO.attribute_id = rdr["attribute_id"].ToString();
                    attributeListDTO.name = rdr["name"].ToString();
                    attributeListDTO.type_id = rdr["type"].ToString();
                    attributeListDTO.value = rdr["value"].ToString();
                    attributeListDTO.isEnabled = rdr["isEnabled"].ToString();
                    attributeListDTO.createdBy = rdr["createdBy"].ToString();
                    attributeListDTO.createdDate = rdr["createdDate"].ToString();
                }
            };
            return attributeListDTO;
        }

        //--------------------------------------------- Inserts --------------------------------------------
        public static bool insertCategorie(CategorieDTO pCategorieDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_categorie", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pCategorieDTO.name;
                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pCategorieDTO.description;
                command.Parameters.Add("@createdBy_id", SqlDbType.Int);
                command.Parameters["@createdBy_id"].Value = pCategorieDTO.createdBy_id;
                command.Parameters.Add("@createdBy_name", SqlDbType.NVarChar);
                command.Parameters["@createdBy_name"].Value = pCategorieDTO.createdBy_name;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }

        public static bool insertGeneralAttribute(GeneralAttributeDTO pGeneralAttributeDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_generalAttribute", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@categorie_id", SqlDbType.Int);
                command.Parameters["@categorie_id"].Value = pGeneralAttributeDTO.categorie_id;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pGeneralAttributeDTO.name;
                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pGeneralAttributeDTO.type_id;
                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pGeneralAttributeDTO.value;
                command.Parameters.Add("@createdBy", SqlDbType.Int);
                command.Parameters["@createdBy"].Value = pGeneralAttributeDTO.createdBy;
                command.Parameters.Add("@pUser", SqlDbType.Int);
                command.Parameters["@pUser"].Value = pGeneralAttributeDTO.user;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }

        public static bool insertPersonalAttribute(PersonalAttributeDTO pGeneralAttributeDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_personalAttribute", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@categorie_id", SqlDbType.Int);
                command.Parameters["@categorie_id"].Value = pGeneralAttributeDTO.categorie_id;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pGeneralAttributeDTO.name;
                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pGeneralAttributeDTO.type_id;
                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pGeneralAttributeDTO.value;
                command.Parameters.Add("@createdBy", SqlDbType.Int);
                command.Parameters["@createdBy"].Value = pGeneralAttributeDTO.createdBy;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pGeneralAttributeDTO.userLog;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
        public static bool insertAttributeList(AttributeListDTO pAttributeListDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_AttributeList", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@attribute_id", SqlDbType.Int);
                command.Parameters["@attribute_id"].Value = pAttributeListDTO.attribute_id;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pAttributeListDTO.name;
                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pAttributeListDTO.type_id;
                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pAttributeListDTO.value;
                command.Parameters.Add("@createdBy", SqlDbType.Int);
                command.Parameters["@createdBy"].Value = pAttributeListDTO.createdBy;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pAttributeListDTO.user;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
        //--------------------------------------------- Updates --------------------------------------------
        public static bool updateCategorie(CategorieDTO pCategorieDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_categorie", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_categorie", SqlDbType.Int);
                command.Parameters["@id_categorie"].Value = pCategorieDTO.id_categorie;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pCategorieDTO.name;
                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pCategorieDTO.description;
                command.Parameters.Add("@isEnabled", SqlDbType.Bit);
                command.Parameters["@isEnabled"].Value = pCategorieDTO.isEnabled;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }

        public static bool updateGeneralAttribute(GeneralAttributeDTO pGeneralAttributeDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_generalAttribute", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_attribute", SqlDbType.Int);
                command.Parameters["@id_attribute"].Value = pGeneralAttributeDTO.id_attribute;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pGeneralAttributeDTO.name;
                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pGeneralAttributeDTO.type_id;
                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pGeneralAttributeDTO.value;
                command.Parameters.Add("@isEnabled", SqlDbType.Bit);
                command.Parameters["@isEnabled"].Value = pGeneralAttributeDTO.isEnabled;
                command.Parameters.Add("@pUser", SqlDbType.Int);
                command.Parameters["@pUser"].Value = pGeneralAttributeDTO.user;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
        public static bool updatePersonalAttribute(PersonalAttributeDTO pGeneralAttributeDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_personalAttribute", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_attribute", SqlDbType.Int);
                command.Parameters["@id_attribute"].Value = pGeneralAttributeDTO.id_attribute;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pGeneralAttributeDTO.name;
                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pGeneralAttributeDTO.type_id;
                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pGeneralAttributeDTO.value;
                command.Parameters.Add("@isEnabled", SqlDbType.Bit);
                command.Parameters["@isEnabled"].Value = pGeneralAttributeDTO.isEnabled;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pGeneralAttributeDTO.userLog;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
        public static bool updateAttributeList(AttributeListDTO pAttributeListDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_AttributeList", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_attributeValue", SqlDbType.Int);
                command.Parameters["@id_attributeValue"].Value = pAttributeListDTO.id_attributeValue;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pAttributeListDTO.name;
                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pAttributeListDTO.type_id;
                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pAttributeListDTO.value;
                command.Parameters.Add("@isEnabled", SqlDbType.Bit);
                command.Parameters["@isEnabled"].Value = pAttributeListDTO.isEnabled;
                command.Parameters.Add("@pUser", SqlDbType.Int);
                command.Parameters["@pUser"].Value = pAttributeListDTO.user;

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
        public static bool deleteCategorie(string id_categorie)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_categorie", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_categorie", SqlDbType.Int);
                command.Parameters["@id_categorie"].Value = id_categorie;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }

        public static bool deleteGeneralAttribute(string id_attribute, string user)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_generalAttribute", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_attribute", SqlDbType.Int);
                command.Parameters["@id_attribute"].Value = id_attribute;
                command.Parameters.Add("@pUser", SqlDbType.Int);
                command.Parameters["@pUser"].Value = user;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool deletePersonalAttribute(string id_attribute, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_personalAttribute", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_attribute", SqlDbType.Int);
                command.Parameters["@id_attribute"].Value = id_attribute;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool deleteAttributeList(string id_attributeValue, string user)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_AttributeList", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_attributeValue", SqlDbType.Int);
                command.Parameters["@id_attributeValue"].Value = id_attributeValue;
                command.Parameters.Add("@pUser", SqlDbType.Int);
                command.Parameters["@pUser"].Value = user;

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
