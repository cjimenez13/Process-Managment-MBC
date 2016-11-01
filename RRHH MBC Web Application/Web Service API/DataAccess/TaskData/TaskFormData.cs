using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess.TaskData
{
    class TaskFormData
    {
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

        public static List<TaskFormUserDTO> getFormUsers(string taskForm_id)
        {
            List<TaskFormUserDTO> formUsers = new List<TaskFormUserDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_formUsers", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@taskForm_id", SqlDbType.Int);
                command.Parameters["@taskForm_id"].Value = taskForm_id;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskFormUserDTO formUSer = new TaskFormUserDTO();
                    formUSer.user_id = rdr["user_id"].ToString();
                    formUSer.taskForm_id = rdr["taskForm_id"].ToString();
                    formUSer.isAnswered = rdr["isAnswered"].ToString();
                    formUSer.name = rdr["name"].ToString();
                    formUSer.sLastName = rdr["sLastName"].ToString();
                    formUSer.fLastName = rdr["fLastName"].ToString();
                    formUSer.userName = rdr["userName"].ToString();
                    formUSer.email = rdr["email"].ToString();
                    byte[] photo = (byte[])rdr["photoData"];
                    formUSer.photoData = Convert.ToBase64String(photo);
                    formUsers.Add(formUSer);
                }
            };
            return formUsers;
        }

        public static List<TaskQuestionAnswerDTO> getQuestionsAnswers(string id_taskQuestion)
        {
            List<TaskQuestionAnswerDTO> questionAnswers = new List<TaskQuestionAnswerDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_questionAnswers", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_taskQuestion", SqlDbType.Int);
                command.Parameters["@id_taskQuestion"].Value = id_taskQuestion;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskQuestionAnswerDTO taskQuestionAnswer = new TaskQuestionAnswerDTO();
                    taskQuestionAnswer.user_id = rdr["user_id"].ToString();
                    taskQuestionAnswer.taskQuestion_id = rdr["taskQuestion_id"].ToString();
                    taskQuestionAnswer.answered_date = rdr["answered_date"].ToString();
                    taskQuestionAnswer.question = rdr["question"].ToString();
                    taskQuestionAnswer.questionPosition = rdr["questionPosition"].ToString();
                    taskQuestionAnswer.questionType_id = rdr["questionType_id"].ToString();
                    taskQuestionAnswer.questionType_name = rdr["questionType_name"].ToString();
                    byte[] response = (byte[])rdr["response"];
                    if (taskQuestionAnswer.questionType_id != "5")
                    {
                        taskQuestionAnswer.response = Encoding.UTF8.GetString(response);
                    }
                    else
                    {
                        taskQuestionAnswer.response = Convert.ToBase64String(response);
                    }
                    //byte[] photo = (byte[])rdr["photoData"];
                    //taskQuestionAnswer.photoData = Convert.ToBase64String(photo);
                    questionAnswers.Add(taskQuestionAnswer);
                }
            };
            return questionAnswers;
        }

        //---------------------------------------------------------- Inserts -------------------------------------------------------------------

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

        public static bool insertFormUser(TaskFormUserDTO pFormUser)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_formUser", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@taskForm_id", SqlDbType.Int);
                command.Parameters["@taskForm_id"].Value = pFormUser.taskForm_id;

                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = pFormUser.user_id;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pFormUser.userLog;

                command.Connection.Open();
                string result = command.ExecuteScalar().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool insertQuestionAnswer(TaskQuestionAnswerDTO pQuestionAnswer)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_questionAnswer", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@response", SqlDbType.VarBinary);
                command.Parameters["@response"].Value = pQuestionAnswer.responseData;

                command.Parameters.Add("@taskQuestion_id", SqlDbType.BigInt);
                command.Parameters["@taskQuestion_id"].Value = pQuestionAnswer.taskQuestion_id;

                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = pQuestionAnswer.user_id;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pQuestionAnswer.userLog;

                command.Connection.Open();
                string result = command.ExecuteScalar().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }


        //--------------------------------------------- Updates --------------------------------------------

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
        public static bool deleteFormUser(TaskFormUserDTO formUserDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_formUser", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@taskForm_id", SqlDbType.BigInt);
                command.Parameters["@taskForm_id"].Value = formUserDTO.taskForm_id;
                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = formUserDTO.user_id;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = formUserDTO.userLog;

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
