using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess
{
    class TaskData
    {
        public static List<TaskDTO> getTasks(string id_stage)
        {
            List<TaskDTO> tasks = new List<TaskDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_process_tasks", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_stage", SqlDbType.Int);
                command.Parameters["@id_stage"].Value = id_stage;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskDTO task = new TaskDTO();
                    task.id_task = rdr["id_task"].ToString();
                    task.name = rdr["name"].ToString();
                    task.description = rdr["description"].ToString();
                    task.type_id = rdr["type_id"].ToString();
                    task.taskState_id = rdr["taskState_id"].ToString();
                    task.createdBy = rdr["createdBy"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.taskPosition = rdr["taskPosition"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.createdDate = rdr["createdDate"].ToString();
                    task.beginDate = rdr["beginDate"].ToString();
                    tasks.Add(task);
                }
            };
            return tasks;
        }
        public static TaskDTO getTask(string id_task)
        {
            TaskDTO task = new TaskDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_process_task", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = id_task;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    task.id_task = rdr["id_task"].ToString();
                    task.name = rdr["name"].ToString();
                    task.description = rdr["description"].ToString();
                    task.type_id = rdr["type_id"].ToString();
                    task.taskState_id = rdr["taskState_id"].ToString();
                    task.createdBy = rdr["createdBy"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.taskPosition = rdr["taskPosition"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.createdDate = rdr["createdDate"].ToString();
                }
            };
            return task;
        }
        public static List<TaskTypeDTO> getTaskTypes()
        {
            List<TaskTypeDTO> taskTypes = new List<TaskTypeDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_taskTypes", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskTypeDTO taskType = new TaskTypeDTO();
                    taskType.id_taskType = rdr["id_taskType"].ToString();
                    taskType.taskName = rdr["taskName"].ToString();
                    taskType.needConfirm = rdr["needConfirm"].ToString();
                    taskType.formNeeded = rdr["formNeeded"].ToString();
                    taskTypes.Add(taskType);
                }
            };
            return taskTypes;
        }
        public static TaskTypeDTO getTaskType(string id_taskType)
        {
            TaskTypeDTO taskType = new TaskTypeDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_taskTypes", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_taskType", SqlDbType.Int);
                command.Parameters["@id_taskType"].Value = id_taskType;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    taskType.taskName = rdr["taskName"].ToString();
                    taskType.needConfirm = rdr["needConfirm"].ToString();
                    taskType.formNeeded = rdr["formNeeded"].ToString();
                }
            };
            return taskType;
        }
        public static List<TaskStateDTO> getTaskStates()
        {
            List<TaskStateDTO> taskStates = new List<TaskStateDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_taskStates", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskStateDTO taskState = new TaskStateDTO();
                    taskState.id_taskState = rdr["id_taskState"].ToString();
                    taskState.state_name = rdr["state_name"].ToString();
                    taskState.state_color = rdr["state_color"].ToString();
                    taskStates.Add(taskState);
                }
            };
            return taskStates;
        }
        public static TaskStateDTO getTaskState(string id_taskType)
        {
            TaskStateDTO taskState = new TaskStateDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_taskState", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_taskType", SqlDbType.Int);
                command.Parameters["@id_taskType"].Value = id_taskType;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    taskState.id_taskState = rdr["id_taskState"].ToString();
                    taskState.state_name = rdr["state_name"].ToString();
                    taskState.state_color = rdr["state_color"].ToString();
                }
            };
            return taskState;
        }
        //--------------------------------------------- Inserts --------------------------------------------
        public static bool insertTask(TaskDTO pTask)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_task", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@stage_id", SqlDbType.Int);
                command.Parameters["@stage_id"].Value = pTask;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pTask.name;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pTask.description;

                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pTask.type_id;

                command.Parameters.Add("@finishDate", SqlDbType.NVarChar);
                command.Parameters["@finishDate"].Value = pTask.finishDate;

                command.Parameters.Add("@taskPosition", SqlDbType.NVarChar);
                command.Parameters["@taskPosition"].Value = pTask.taskPosition;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTask.userLog;

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
        public static bool updateTask(TaskDTO pTask)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_task", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = pTask;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pTask.name;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pTask.description;

                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pTask.type_id;

                command.Parameters.Add("@taskState_id", SqlDbType.Int);
                command.Parameters["@taskState_id"].Value = pTask.taskState_id;

                command.Parameters.Add("@completedDate", SqlDbType.Int);
                command.Parameters["@completedDate"].Value = pTask.completedDate;

                command.Parameters.Add("@finishDate", SqlDbType.NVarChar);
                command.Parameters["@finishDate"].Value = pTask.finishDate;

                command.Parameters.Add("@taskPosition", SqlDbType.NVarChar);
                command.Parameters["@taskPosition"].Value = pTask.taskPosition;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTask.userLog;

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
        public static bool deleteTask(string id_task, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_task", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = id_task;
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
