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
                    task.finishDate = rdr["finishDate"].ToString();
                    task.taskPosition = rdr["taskPosition"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.createdDate = rdr["createdDate"].ToString();
                    task.beginDate = rdr["beginDate"].ToString();
                    task.daysAvailable = rdr["daysAvailable"].ToString();
                    task.hoursAvailable = rdr["hoursAvailable"].ToString();
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
                    task.finishDate = rdr["finishDate"].ToString();
                    task.taskPosition = rdr["taskPosition"].ToString();
                    task.finishDate = rdr["finishDate"].ToString();
                    task.createdDate = rdr["createdDate"].ToString();
                    task.daysAvailable = rdr["daysAvailable"].ToString();
                    task.hoursAvailable = rdr["hoursAvailable"].ToString();
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
        public static TaskFormDTO getTaskForm(string id_task)
        {
            TaskFormDTO taskForm = new TaskFormDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_getTaskForm", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = id_task;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    taskForm.id_taskForm = rdr["id_taskForm"].ToString();
                    taskForm.id_task = rdr["task_id"].ToString();
                    taskForm.description = rdr["description"].ToString();
                }
            };
            return taskForm;
        }
        public static List<TaskQuestionDTO> getTaskQuestions(string taskForm_id)
        {
            List<TaskQuestionDTO> taskQuestions = new List<TaskQuestionDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_getTaskQuestions", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@taskForm_id", SqlDbType.Int);
                command.Parameters["@taskForm_id"].Value = taskForm_id;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskQuestionDTO taskQuestion = new TaskQuestionDTO();
                    taskQuestion.id_taskQuestion = rdr["id_TaskQuestion"].ToString();
                    taskQuestion.taskForm_id = rdr["taskForm_id"].ToString();
                    taskQuestion.question = rdr["question"].ToString();
                    taskQuestion.generalAttributeList = rdr["generalAttributeList"].ToString();
                    taskQuestion.questionType_id = rdr["questionType_id"].ToString();
                    taskQuestion.questionPosition = rdr["questionPosition"].ToString();
                    taskQuestion.isRequired = rdr["isRequired"].ToString();
                    /*
                    try
                    {
                        byte[] response = (byte[])rdr["response"];
                        if (taskQuestion.questionType_id == "5")
                        {
                            taskQuestion.response = Convert.ToBase64String(response);
                        }
                        else
                        {
                            taskQuestion.response = Encoding.UTF8.GetString(response);
                        }
                    }
                    catch (Exception e)
                    {

                    }
                    **/
                    taskQuestions.Add(taskQuestion);
                }
            };
            return taskQuestions;
        }
        public static List<QuestionTypeDTO> getQuestionTypes()
        {
            List<QuestionTypeDTO> questionTypes = new List<QuestionTypeDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_questionTypes", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    QuestionTypeDTO questionType = new QuestionTypeDTO();
                    questionType.id_questionType = rdr["id_questionType"].ToString();
                    questionType.name = rdr["name"].ToString();
                    questionTypes.Add(questionType);
                }
            };
            return questionTypes;
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
        public static bool insertForm(TaskFormDTO pTaskForm)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_form", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = pTaskForm.id_task;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pTaskForm.description;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskForm.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool insertQuestion(TaskQuestionDTO pTaskQuestion)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_question", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@taskForm_id", SqlDbType.Int);
                command.Parameters["@taskForm_id"].Value = pTaskQuestion.taskForm_id;

                command.Parameters.Add("@question", SqlDbType.NVarChar);
                command.Parameters["@question"].Value = pTaskQuestion.question;

                command.Parameters.Add("@generalAttributeList", SqlDbType.Int);
                command.Parameters["@generalAttributeList"].Value = pTaskQuestion.generalAttributeList;

                command.Parameters.Add("@questionType_id", SqlDbType.Int);
                command.Parameters["@questionType_id"].Value = pTaskQuestion.questionType_id;

                command.Parameters.Add("@questionPosition", SqlDbType.Int);
                command.Parameters["@questionPosition"].Value = pTaskQuestion.questionPosition;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskQuestion.userLog;

                command.Parameters.Add("@isRequired", SqlDbType.Bit);
                command.Parameters["@isRequired"].Value = pTaskQuestion.isRequired;

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

                command.Parameters.Add("@task_id", SqlDbType.Int);
                command.Parameters["@task_id"].Value = pTaskResponsable.task_id;

                command.Parameters.Add("@group_id", SqlDbType.Int);
                command.Parameters["@group_id"].Value = pTaskResponsable.user_id;

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
        public static bool updateQuestion(TaskQuestionDTO pTaskQuestion)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_question", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_taskQuestion", SqlDbType.Int);
                command.Parameters["@id_taskQuestion"].Value = pTaskQuestion.id_taskQuestion;
                /*
                byte[] response = null;
                if (pTaskQuestion.response != null)
                {
                    if (pTaskQuestion.questionType_id != "5")
                    {
                        response = Encoding.UTF8.GetBytes(pTaskQuestion.question);
                    }
                    else
                    {

                    }
                }
                */
                command.Parameters.Add("@question", SqlDbType.NVarChar);
                command.Parameters["@question"].Value = pTaskQuestion.question;

                command.Parameters.Add("@generalAttributeList", SqlDbType.Int);
                command.Parameters["@generalAttributeList"].Value = pTaskQuestion.generalAttributeList;

                command.Parameters.Add("@questionType_id", SqlDbType.Int);
                command.Parameters["@questionType_id"].Value = pTaskQuestion.questionType_id;

                command.Parameters.Add("@questionPosition", SqlDbType.Int);
                command.Parameters["@questionPosition"].Value = pTaskQuestion.questionPosition;

                command.Parameters.Add("@isRequired", SqlDbType.Bit);
                command.Parameters["@isRequired"].Value = pTaskQuestion.isRequired;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskQuestion.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool updateForm(TaskFormDTO pTaskForm)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_form", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_taskForm", SqlDbType.Int);
                command.Parameters["@id_taskForm"].Value = pTaskForm.id_taskForm;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pTaskForm.description;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskForm.userLog;

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
        public static bool deleteQuestion(string id_taskQuestion, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_question", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_taskQuestion", SqlDbType.Int);
                command.Parameters["@id_taskQuestion"].Value = id_taskQuestion;
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
