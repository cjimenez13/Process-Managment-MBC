using DataTransferObjects;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess
{
    class TemplatesData
    {
        public static List<TemplateDTO> getTemplates()
        {
            List<TemplateDTO> templates = new List<TemplateDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_templates", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TemplateDTO template = new TemplateDTO();
                    template.id_processManagment = rdr["id_processManagment"].ToString();
                    template.name = rdr["name"].ToString();
                    template.createdBy = rdr["createdBy"].ToString();
                    template.createdDate = rdr["createdDate"].ToString();
                    template.categorie_id = rdr["categorie_id"].ToString();
                    template.categorie_name = rdr["categorie_name"].ToString();
                    templates.Add(template);
                }
            };
            return templates;
        }
        public static TemplateDTO getTemplate(string id_template)
        {
            TemplateDTO template = new TemplateDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_template", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_template", SqlDbType.Int);
                command.Parameters["@id_template"].Value = id_template;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    template.id_processManagment = rdr["id_processManagment"].ToString();
                    template.name = rdr["name"].ToString();
                    template.createdBy = rdr["createdBy"].ToString();
                    template.createdDate = rdr["createdDate"].ToString();
                    template.categorie_id = rdr["categorie_id"].ToString();
                    template.categorie_name = rdr["categorie_name"].ToString();
                }
            };
            return template;
        }
        //--------------------------------------------- Inserts --------------------------------------------
        public static bool insertTemplate(TemplateDTO pTemplateDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_template", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pTemplateDTO.name;
                command.Parameters.Add("@categorie_id", SqlDbType.NVarChar);
                command.Parameters["@categorie_id"].Value = pTemplateDTO.categorie_id;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTemplateDTO.userLog;

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
        public static bool updateTemplate(TemplateDTO pTemplateDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_template", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_template", SqlDbType.Int);
                command.Parameters["@id_template"].Value = pTemplateDTO.id_processManagment;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pTemplateDTO.name;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTemplateDTO.userLog;

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
        public static bool deleteTemplate(string id_template, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_template", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_template", SqlDbType.Int);
                command.Parameters["@id_template"].Value = id_template;
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
    }
}
