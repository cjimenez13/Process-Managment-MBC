using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess.TaskData
{
    public class TaskFilesData
    {
        public static List<FileTaskDTO> getTaskFiles(string id_task)
        {
            List<FileTaskDTO> fileDTOList = new List<FileTaskDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_taskFiles", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add("@id_task", SqlDbType.NVarChar);
                command.Parameters["@id_task"].Value = id_task;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    FileTaskDTO fileDTO = new FileTaskDTO();
                    fileDTO.name = rdr["name"].ToString();
                    fileDTO.description = rdr["description"].ToString();
                    fileDTO.createdDate = rdr["createdDate"].ToString();
                    fileDTO.id_taskFile = rdr["id_taskFile"].ToString();
                    fileDTO.fileType = rdr["fileType"].ToString();
                    fileDTO.fileName = rdr["fileName"].ToString();
                    fileDTO.task_id = rdr["task_id"].ToString();
                    byte[] file = (byte[])rdr["fileData"];
                    fileDTO.fileBase64 = Convert.ToBase64String(file);
                    fileDTOList.Add(fileDTO);
                }
            };
            return fileDTOList;
        }
        //-------------------------------------------------- Creates -----------------------------------------------------------------

        public static bool postFile(FileTaskDTO pFileDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_taskFile", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_task", SqlDbType.BigInt);
                command.Parameters["@id_task"].Value = pFileDTO.task_id;

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

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pFileDTO.userLog;

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
        public static bool deleteFile(string id_file, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_taskFile", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_taskFile", SqlDbType.Int);
                command.Parameters["@id_taskFile"].Value = id_file;

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