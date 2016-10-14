using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess.TaskData
{
    public class TaskChangesData
    {
        public static List<TaskChangeDTO> getTaskChanges(string id_task)
        {
            List<TaskChangeDTO> taskChanges = new List<TaskChangeDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_TaskChanges", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = id_task;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskChangeDTO taskChange = new TaskChangeDTO();
                    taskChange.id_taskChange = rdr["id_taskChange"].ToString();
                    taskChange.task_id = rdr["task_id"].ToString();
                    taskChange.attribute_id = rdr["attribute_id"].ToString();
                    taskChange.attributeList_id = rdr["attributeList_id"].ToString();
                    taskChange.operation_id = rdr["operation_id"].ToString();
                    taskChange.value = rdr["value"].ToString();
                    taskChange.attributeList_type = rdr["attributeList_type"].ToString();
                    taskChange.attribute_type = rdr["attribute_type"].ToString();
                    taskChanges.Add(taskChange);
                }
            };
            return taskChanges;
        }
        public static List<OperationTypeDTO> getOperationTypes()
        {
            List<OperationTypeDTO> operationTypes = new List<OperationTypeDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_OperationTypes", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    OperationTypeDTO operationType = new OperationTypeDTO();
                    operationType.id_operationType = rdr["id_operationType"].ToString();
                    operationType.displayName = rdr["displayName"].ToString();
                    operationType.operation = rdr["operation"].ToString();
                    operationType.reg_expr = rdr["reg_expr"].ToString();
                    operationTypes.Add(operationType);
                }
            };
            return operationTypes;
        }
        //---------------------------------------------------------- Inserts -------------------------------------------------------------------
        public static bool insertTaskChange(TaskChangeDTO pTaskChange)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_taskChange", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@task_id", SqlDbType.Int);
                command.Parameters["@task_id"].Value = pTaskChange.task_id;

                command.Parameters.Add("@attribute_id", SqlDbType.Int);
                command.Parameters["@attribute_id"].Value = pTaskChange.attribute_id;

                command.Parameters.Add("@attributeList_id", SqlDbType.Int);
                command.Parameters["@attributeList_id"].Value = pTaskChange.attributeList_id;

                command.Parameters.Add("@operation_id", SqlDbType.Int);
                command.Parameters["@operation_id"].Value = pTaskChange.operation_id;

                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pTaskChange.value;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskChange.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        //--------------------------------------------- Updates --------------------------------------------
        public static bool updateTaskChange(TaskChangeDTO pTaskChange)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_taskChange", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_taskChange", SqlDbType.Int);
                command.Parameters["@id_taskChange"].Value = pTaskChange.id_taskChange;

                command.Parameters.Add("@attribute_id", SqlDbType.Int);
                command.Parameters["@attribute_id"].Value = pTaskChange.attribute_id;

                command.Parameters.Add("@attributeList_id", SqlDbType.Int);
                command.Parameters["@attributeList_id"].Value = pTaskChange.attributeList_id;

                command.Parameters.Add("@operation_id", SqlDbType.Int);
                command.Parameters["@operation_id"].Value = pTaskChange.operation_id;

                command.Parameters.Add("@value", SqlDbType.NVarChar);
                command.Parameters["@value"].Value = pTaskChange.value;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskChange.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        //------------------------------------------------ Deletes ----------------------------------------------------
        public static bool deleteTask(string id_taskChange, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_taskChange", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_taskChange", SqlDbType.Int);
                command.Parameters["@id_taskChange"].Value = id_taskChange;
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
