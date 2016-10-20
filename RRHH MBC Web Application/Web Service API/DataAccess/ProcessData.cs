using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess
{
    class ProcessData
    {
        public static List<ProcessDTO> getProcesses()
        {
            List<ProcessDTO> processes = new List<ProcessDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_processes", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    ProcessDTO process = new ProcessDTO();
                    process.id_processManagment = rdr["id_processManagment"].ToString();
                    process.name = rdr["name"].ToString();
                    process.createdBy = rdr["createdBy"].ToString();
                    process.createdDate = rdr["createdDate"].ToString();
                    process.categorie_id = rdr["categorie_id"].ToString();
                    process.categorie_name = rdr["categorie_name"].ToString();
                    process.completedPorcentage = rdr["completedPorcentage"].ToString();
                    process.template_id = rdr["template_id"].ToString();
                    process.state_id = rdr["state_id"].ToString();
                    process.state_name = rdr["state_name"].ToString();
                    process.state_color = rdr["state_color"].ToString();
                    process.template_id = rdr["template_id"].ToString();
                    process.template_name = rdr["template_name"].ToString();
                    process.completedTasks = rdr["completedTasks"].ToString();
                    process.totalTasks = rdr["totalTasks"].ToString();
                    processes.Add(process);
                }
            };
            return processes;
        }
        public static ProcessDTO getProcess(string id_process)
        {
            ProcessDTO process = new ProcessDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_process", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_process", SqlDbType.BigInt);
                command.Parameters["@id_process"].Value = id_process;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    process.id_processManagment = rdr["id_processManagment"].ToString();
                    process.name = rdr["name"].ToString();
                    process.createdBy = rdr["createdBy"].ToString();
                    process.createdDate = rdr["createdDate"].ToString();
                    process.categorie_id = rdr["categorie_id"].ToString();
                    process.categorie_name = rdr["categorie_name"].ToString();
                    process.completedPorcentage = rdr["completedPorcentage"].ToString();
                    process.template_id = rdr["template_id"].ToString();
                    process.state_id = rdr["state_id"].ToString();
                    process.state_name = rdr["state_name"].ToString();
                    process.state_color = rdr["state_color"].ToString();
                    process.template_id = rdr["template_id"].ToString();
                    process.template_name = rdr["template_name"].ToString();
                    process.completedTasks = rdr["completedTasks"].ToString();
                    process.totalTasks = rdr["totalTasks"].ToString();
                }
            };
            return process;
        }
        //--------------------------------------------- Inserts --------------------------------------------
        public static bool insertProcess(ProcessDTO pProcessDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_process", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pProcessDTO.name;
                command.Parameters.Add("@categorie_id", SqlDbType.Int);
                command.Parameters["@categorie_id"].Value = pProcessDTO.categorie_id;
                command.Parameters.Add("@template_id", SqlDbType.BigInt);
                command.Parameters["@template_id"].Value = pProcessDTO.template_id;
                command.Parameters.Add("@previousProcess", SqlDbType.BigInt);
                command.Parameters["@previousProcess"].Value = pProcessDTO.previousProcess;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pProcessDTO.userLog;

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
        public static bool updateProcess(ProcessDTO pProcessDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_process", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_process", SqlDbType.Int);
                command.Parameters["@id_process"].Value = pProcessDTO.id_processManagment;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pProcessDTO.name;
                command.Parameters.Add("@previousProcess", SqlDbType.BigInt);
                command.Parameters["@previousProcess"].Value = pProcessDTO.previousProcess;
                command.Parameters.Add("@nextProcess", SqlDbType.BigInt);
                command.Parameters["@nextProcess"].Value = pProcessDTO.nextProcess;
                command.Parameters.Add("@completedPorcentage", SqlDbType.Int);
                command.Parameters["@completedPorcentage"].Value = pProcessDTO.completedPorcentage;
                command.Parameters.Add("@state_id", SqlDbType.TinyInt);
                command.Parameters["@state_id"].Value = pProcessDTO.state_id;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pProcessDTO.userLog;

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
        public static bool deleteProcess(string id_process, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_process", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_process", SqlDbType.Int);
                command.Parameters["@id_process"].Value = id_process;

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
