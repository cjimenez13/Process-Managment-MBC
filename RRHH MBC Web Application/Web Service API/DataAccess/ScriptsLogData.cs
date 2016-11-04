using DataTransferObjects;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.Script.Serialization;


namespace Web_Service_API.DataAccess
{
    class ScriptsLogData
    {

        public static string executeSQL(ScriptsLogDTO scriptLogDTO)
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(scriptLogDTO.script, connection);
                command.Connection.Open();
                if (scriptLogDTO.script.ToLower().Contains("select"))
                {
                    SqlDataAdapter da = new SqlDataAdapter(command);
                    da.Fill(dataTable);
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dataTable.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dataTable.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }
                    return serializer.Serialize(rows);
                }
                else
                {
                    return command.ExecuteNonQuery().ToString();
                }
            };
        }
        public static List<ScriptsLogDTO> getScriptsLog()
        {
            List<ScriptsLogDTO> templates = new List<ScriptsLogDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_scriptsLog", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    ScriptsLogDTO scriptLog = new ScriptsLogDTO();
                    scriptLog.id_scriptLog = rdr["id_scriptLog"].ToString();
                    scriptLog.script = rdr["script"].ToString();
                    scriptLog.ejecutedBy = rdr["ejecutedBy"].ToString();
                    scriptLog.ejecutedDate = rdr["ejecutedDate"].ToString();
                    scriptLog.ejecutedBy_name = rdr["name"].ToString() + " " + rdr["fLastName"].ToString() + " " + rdr["sLastName"].ToString();
                    templates.Add(scriptLog);
                }
            };
            return templates;
        }
        //--------------------------------------------- Inserts --------------------------------------------
        public static bool insertScriptLog(ScriptsLogDTO scriptLogDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_scriptLog", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@script", SqlDbType.NVarChar);
                command.Parameters["@script"].Value = scriptLogDTO.script;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = scriptLogDTO.userLog;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
    }
}
