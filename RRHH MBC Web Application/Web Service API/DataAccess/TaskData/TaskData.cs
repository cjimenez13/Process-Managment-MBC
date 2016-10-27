using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess.TaskData
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
                    task.stage_id = rdr["stage_id"].ToString();
                    task.taskState_id = rdr["taskState_id"].ToString();
                    task.createdBy = rdr["createdBy"].ToString();
                    task.taskPosition = rdr["taskPosition"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.createdDate = rdr["createdDate"].ToString();
                    task.beginDate = rdr["beginDate"].ToString();
                    task.daysAvailable = rdr["daysAvailable"].ToString();
                    task.hoursAvailable = rdr["hoursAvailable"].ToString();
                    task.isProcess = rdr["isProcess"].ToString();
                    tasks.Add(task);
                }
            };
            return tasks;
        }
        public static List<TaskDTO> getTasksbyUser(string user_id)
        {
            List<TaskDTO> tasks = new List<TaskDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_userTasks", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = user_id;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskDTO task = new TaskDTO();
                    task.id_task = rdr["id_task"].ToString();
                    task.name = rdr["name"].ToString();
                    task.description = rdr["description"].ToString();
                    task.type_id = rdr["type_id"].ToString();
                    task.stage_id = rdr["stage_id"].ToString();
                    task.taskState_id = rdr["taskState_id"].ToString();
                    task.createdBy = rdr["createdBy"].ToString();
                    task.taskPosition = rdr["taskPosition"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.createdDate = rdr["createdDate"].ToString();
                    task.beginDate = rdr["beginDate"].ToString();
                    task.daysAvailable = rdr["daysAvailable"].ToString();
                    task.hoursAvailable = rdr["hoursAvailable"].ToString();
                    task.process_name = rdr["process_name"].ToString();
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
                    task.stage_id = rdr["stage_id"].ToString();
                    task.taskState_id = rdr["taskState_id"].ToString();
                    task.createdBy = rdr["createdBy"].ToString();
                    task.taskPosition = rdr["taskPosition"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.createdDate = rdr["createdDate"].ToString();
                    task.daysAvailable = rdr["daysAvailable"].ToString();
                    task.hoursAvailable = rdr["hoursAvailable"].ToString();
                    task.isProcess = rdr["isProcess"].ToString();
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
                SqlCommand command = new SqlCommand("usp_get_taskType", connection);
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
                command.Parameters.Add("@id_taskState", SqlDbType.Int);
                command.Parameters["@id_taskState"].Value = id_taskType;
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
        public static List<TaskResponsableDTO> getTaskResponsables(string task_id)
        {
            List<TaskResponsableDTO> taskResponsables = new List<TaskResponsableDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_taskTargets", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@task_id", SqlDbType.Int);
                command.Parameters["@task_id"].Value = task_id;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskResponsableDTO taskResponsable = new TaskResponsableDTO();
                    taskResponsable.user_id = rdr["user_id"].ToString();
                    taskResponsable.isConfirmed = rdr["isConfirmed"].ToString();
                    taskResponsable.name = rdr["name"].ToString();
                    taskResponsable.sLastName = rdr["sLastName"].ToString();
                    taskResponsable.fLastName = rdr["fLastName"].ToString();
                    taskResponsable.userName = rdr["userName"].ToString();
                    taskResponsable.email = rdr["email"].ToString();
                    byte[] photo = (byte[])rdr["photoData"];
                    taskResponsable.photoData = Convert.ToBase64String(photo);
                    taskResponsables.Add(taskResponsable);
                }
            };
            return taskResponsables;
        }
        public static List<ParticipantDTO> getTaskParticipants(string id_task)
        {
            List<ParticipantDTO> participants = new List<ParticipantDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_participantsTask", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = id_task;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    ParticipantDTO participant = new ParticipantDTO();
                    participant.processManagment_id = rdr["processManagment_id"].ToString();
                    participant.name = rdr["name"].ToString();
                    participant.user_id = rdr["user_id"].ToString();
                    participant.sLastName = rdr["sLastName"].ToString();
                    participant.fLastName = rdr["fLastName"].ToString();
                    participant.userName = rdr["userName"].ToString();
                    participant.email = rdr["email"].ToString();
                    byte[] photo = (byte[])rdr["photoData"];
                    participant.photoData = Convert.ToBase64String(photo);
                    participants.Add(participant);
                }
            };
            return participants;
        }
        
        public static List<AttributeDTO> getTaskAttributes(string task_id)
        {
            List<AttributeDTO> attributes = new List<AttributeDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_availableAttributesbyTask", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@task_id", SqlDbType.Int);
                command.Parameters["@task_id"].Value = task_id;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    AttributeDTO attribute = new AttributeDTO();
                    attribute.categorie_id = rdr["categorie_id"].ToString();
                    attribute.type_id = rdr["type"].ToString();
                    attribute.isGeneral = rdr["isGeneral"].ToString();
                    attribute.id_attribute = rdr["id_attribute"].ToString();
                    attribute.name = rdr["name"].ToString();
                    attributes.Add(attribute);
                }
            };
            return attributes;
        }


        //---------------------------------------------------------- Inserts -------------------------------------------------------------------
        public static string insertTask(TaskDTO pTask)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_task", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@stage_id", SqlDbType.Int);
                command.Parameters["@stage_id"].Value = pTask.stage_id;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pTask.name;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pTask.description;

                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pTask.type_id;
                if (pTask.finishDate != null)
                {
                    command.Parameters.Add("@finishDate", SqlDbType.DateTime);
                    command.Parameters["@finishDate"].Value = DateTime.Parse(pTask.finishDate); ;
                }
                command.Parameters.Add("@taskPosition", SqlDbType.Int);
                command.Parameters["@taskPosition"].Value = pTask.taskPosition;

                command.Parameters.Add("@daysAvailable", SqlDbType.Int);
                command.Parameters["@daysAvailable"].Value = pTask.daysAvailable;

                command.Parameters.Add("@hoursAvailable", SqlDbType.Int);
                command.Parameters["@hoursAvailable"].Value = pTask.hoursAvailable;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTask.userLog;

                command.Connection.Open();
                string result = command.ExecuteScalar().ToString();
                if (result != null)
                {
                    return result;
                }
                return result;
            };
        }
        public static bool insertResponsableUser(TaskResponsableDTO pTaskResponsable)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_usertaskTargets", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@task_id", SqlDbType.Int);
                command.Parameters["@task_id"].Value = pTaskResponsable.task_id;

                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = pTaskResponsable.user_id;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskResponsable.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool insertResponsableGroup(TaskResponsableDTO pTaskResponsable)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_grouptaskTargets", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@task_id", SqlDbType.Int);
                command.Parameters["@task_id"].Value = pTaskResponsable.task_id;

                command.Parameters.Add("@group_id", SqlDbType.Int);
                command.Parameters["@group_id"].Value = pTaskResponsable.user_id;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskResponsable.userLog;

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
        public static bool updateTask(TaskDTO pTask)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_task", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = pTask.id_task;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pTask.name;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pTask.description;

                command.Parameters.Add("@type_id", SqlDbType.Int);
                command.Parameters["@type_id"].Value = pTask.type_id;

                command.Parameters.Add("@taskState_id", SqlDbType.Int);
                command.Parameters["@taskState_id"].Value = pTask.taskState_id;

                command.Parameters.Add("@completedDate", SqlDbType.DateTime);
                command.Parameters["@completedDate"].Value = pTask.completedDate;

                command.Parameters.Add("@finishDate", SqlDbType.DateTime);
                command.Parameters["@finishDate"].Value = pTask.finishDate;

                command.Parameters.Add("@taskPosition", SqlDbType.Int);
                command.Parameters["@taskPosition"].Value = pTask.taskPosition;

                command.Parameters.Add("@daysAvailable", SqlDbType.Int);
                command.Parameters["@daysAvailable"].Value = pTask.daysAvailable;

                command.Parameters.Add("@hoursAvailable", SqlDbType.Int);
                command.Parameters["@hoursAvailable"].Value = pTask.hoursAvailable;

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
        public static bool updateResponsableTask(TaskResponsableDTO pTaskResponsable)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_taskTarget", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = pTaskResponsable.task_id;

                command.Parameters.Add("@id_user", SqlDbType.Int);
                command.Parameters["@id_user"].Value = pTaskResponsable.user_id;

                command.Parameters.Add("@isConfirmed", SqlDbType.Bit);
                command.Parameters["@isConfirmed"].Value = pTaskResponsable.isConfirmed;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskResponsable.userLog;

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
        public static bool deleteResponsable(string id_task, string user_id, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_taskTarget", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = id_task;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = userLog;
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

    }
}
