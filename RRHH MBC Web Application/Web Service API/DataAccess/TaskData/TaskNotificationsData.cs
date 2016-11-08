using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess.TaskData
{
    public class TaskNotificationsData
    {

        public static List<TaskNotificationDTO> getTaskNotifications(string id_task)
        {
            List<TaskNotificationDTO> taskNotifications = new List<TaskNotificationDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_taskNotifications", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_task", SqlDbType.Int);
                command.Parameters["@id_task"].Value = id_task;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskNotificationDTO taskNotification = new TaskNotificationDTO();
                    taskNotification.id_notification = rdr["id_notification"].ToString();
                    taskNotification.message = rdr["message"].ToString();
                    taskNotification.task_id = rdr["task_id"].ToString();
                    taskNotification.isStarting = rdr["isStarting"].ToString();
                    taskNotification.isEmail = rdr["isEmail"].ToString();
                    taskNotification.isTelegram = rdr["isTelegram"].ToString();
                    taskNotification.isIntern = rdr["isIntern"].ToString();
                    taskNotifications.Add(taskNotification);
                }
            };
            return taskNotifications;
        }
        public static bool insertTaskNotification(TaskNotificationDTO pTaskNotification)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_taskNotification", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@task_id", SqlDbType.Int);
                command.Parameters["@task_id"].Value = pTaskNotification.task_id;

                command.Parameters.Add("@message", SqlDbType.NVarChar);
                command.Parameters["@message"].Value = pTaskNotification.message;

                command.Parameters.Add("@isStarting", SqlDbType.Bit);
                command.Parameters["@isStarting"].Value = pTaskNotification.isStarting;

                command.Parameters.Add("@isTelegram", SqlDbType.Bit);
                command.Parameters["@isTelegram"].Value = pTaskNotification.isTelegram;

                command.Parameters.Add("@isIntern", SqlDbType.Bit);
                command.Parameters["@isIntern"].Value = pTaskNotification.isIntern;

                command.Parameters.Add("@isEmail", SqlDbType.Bit);
                command.Parameters["@isEmail"].Value = pTaskNotification.isEmail;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskNotification.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool updateTaskNotification(TaskNotificationDTO pTaskNotification)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_taskNotification", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_notification", SqlDbType.Int);
                command.Parameters["@id_notification"].Value = pTaskNotification.id_notification;

                command.Parameters.Add("@message", SqlDbType.NVarChar);
                command.Parameters["@message"].Value = pTaskNotification.message;

                command.Parameters.Add("@isStarting", SqlDbType.Bit);
                command.Parameters["@isStarting"].Value = pTaskNotification.isStarting;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskNotification.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool deleteTaskNotification(string id_notification, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_notification", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_notification", SqlDbType.Int);
                command.Parameters["@id_notification"].Value = id_notification;
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

        // Notification Types

        public static bool insertTaskNotificationType(TaskNotificationTypeDTO pTaskNotificationType)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_taskNotificationType", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_notification", SqlDbType.Int);
                command.Parameters["@id_notification"].Value = pTaskNotificationType.notification_id;

                command.Parameters.Add("@id_notificationType", SqlDbType.Int);
                command.Parameters["@id_notificationType"].Value = pTaskNotificationType.type_id;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskNotificationType.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool updateTaskNotificationType(TaskNotificationTypeDTO pTaskNotificationType)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_taskNotificationType", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_notification", SqlDbType.Int);
                command.Parameters["@id_notification"].Value = pTaskNotificationType.notification_id;

                command.Parameters.Add("@id_notificationType", SqlDbType.Int);
                command.Parameters["@id_notificationType"].Value = pTaskNotificationType.type_id;

                command.Parameters.Add("@isSended", SqlDbType.Bit);
                command.Parameters["@isSended"].Value = pTaskNotificationType.isSended;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskNotificationType.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool deleteTaskNotificationType(string id_notification, string id_notificationType, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_taskNotificationType", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_notification", SqlDbType.Int);
                command.Parameters["@id_notification"].Value = id_notification;
                command.Parameters.Add("@id_notificationType", SqlDbType.Int);
                command.Parameters["@id_notificationType"].Value = id_notificationType;
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


        // ---------------------------------------------------- Notifications Users ----------------------------------------------//

        public static List<TaskNotificationUserDTO> getTaskNotificationUsers(string id_notification)
        {
            List<TaskNotificationUserDTO> taskNotificationsUsers = new List<TaskNotificationUserDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_taskNotificationUser", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_notification", SqlDbType.Int);
                command.Parameters["@id_notification"].Value = id_notification;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    TaskNotificationUserDTO taskNotificationUser = new TaskNotificationUserDTO();
                    taskNotificationUser.notification_id = rdr["notification_id"].ToString();
                    taskNotificationUser.user_id = rdr["user_id"].ToString();
                    taskNotificationUser.name = rdr["name"].ToString();
                    taskNotificationUser.sLastName = rdr["sLastName"].ToString();
                    taskNotificationUser.fLastName = rdr["fLastName"].ToString();
                    taskNotificationUser.userName = rdr["userName"].ToString();
                    taskNotificationUser.email = rdr["email"].ToString();
                    taskNotificationUser.telegram_id = rdr["telegram_id"].ToString();
                    byte[] photo = (byte[])rdr["photoData"];
                    taskNotificationUser.photoData = Convert.ToBase64String(photo);
                    taskNotificationsUsers.Add(taskNotificationUser);
                }
            };
            return taskNotificationsUsers;
        }
        public static bool insertTaskNotificationUser(TaskNotificationUserDTO pTaskNotificationType)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_taskNotificationUser", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_notification", SqlDbType.Int);
                command.Parameters["@id_notification"].Value = pTaskNotificationType.notification_id;

                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = pTaskNotificationType.user_id;

                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pTaskNotificationType.userLog;

                command.Connection.Open();
                string result = command.ExecuteNonQuery().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
        public static bool deleteTaskNotificationUser(string id_notification, string user_id, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_taskNotificationUser", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_notification", SqlDbType.Int);
                command.Parameters["@id_notification"].Value = id_notification;
                command.Parameters.Add("@user_id", SqlDbType.Int);
                command.Parameters["@user_id"].Value = user_id;
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