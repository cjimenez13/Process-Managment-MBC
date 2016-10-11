using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess
{
    class ProcessManagmentData
    {
        public static List<ParticipantDTO> getProcessParticipants(string id_process)
        {
            List<ParticipantDTO> participants = new List<ParticipantDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_process_participants", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_processManagment", SqlDbType.Int);
                command.Parameters["@id_processManagment"].Value = id_process;
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
        public static List<StageDTO> getProcessStages(string id_process)
        {
            List<StageDTO> stagesDTO = new List<StageDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_process_stages", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_processManagment", SqlDbType.Int);
                command.Parameters["@id_processManagment"].Value = id_process;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    StageDTO stage = new StageDTO();
                    stage.id_stage = rdr["id_stage"].ToString();
                    stage.name = rdr["name"].ToString();
                    stage.processManagment_id = rdr["processManagment_id"].ToString();
                    stage.stagePosition = rdr["stagePosition"].ToString();
                    stage.createdBy = rdr["createdBy"].ToString();
                    stage.createdDate = rdr["createdDate"].ToString();
                    stagesDTO.Add(stage);
                }
            };
            return stagesDTO;
        }
        public static StageDTO getProcessStage(string id_stage)
        {
            StageDTO stage = new StageDTO();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_get_process_stage", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@id_stage", SqlDbType.Int);
                command.Parameters["@id_stage"].Value = id_stage;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    stage.id_stage = rdr["id_stage"].ToString();
                    stage.name = rdr["name"].ToString();
                    stage.processManagment_id = rdr["processManagment_id"].ToString();
                    stage.stagePosition = rdr["stagePosition"].ToString();
                    stage.createdBy = rdr["createdBy"].ToString();
                    stage.createdDate = rdr["createdDate"].ToString();
                }
            };
            return stage;
        }
        //--------------------------------------------- Inserts --------------------------------------------
        public static bool insertParticipant(ParticipantDTO pParticipantDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_process_participant", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_processManagment", SqlDbType.Int);
                command.Parameters["@id_processManagment"].Value = pParticipantDTO.processManagment_id;
                command.Parameters.Add("@user_id", SqlDbType.NVarChar);
                command.Parameters["@user_id"].Value = pParticipantDTO.user_id;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pParticipantDTO.userLog;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
        public static bool insertGroup(ParticipantDTO pParticipantDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_processGroup", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_processManagment", SqlDbType.Int);
                command.Parameters["@id_processManagment"].Value = pParticipantDTO.processManagment_id;
                command.Parameters.Add("@group_id", SqlDbType.NVarChar);
                command.Parameters["@group_id"].Value = pParticipantDTO.user_id;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pParticipantDTO.userLog;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
        public static bool insertStage(StageDTO pStage)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_insert_stage", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pStage.name;
                command.Parameters.Add("@processManagment_id", SqlDbType.Int);
                command.Parameters["@processManagment_id"].Value = pStage.processManagment_id;
                command.Parameters.Add("@stagePosition", SqlDbType.Int);
                command.Parameters["@stagePosition"].Value = pStage.stagePosition;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pStage.userLog;

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
        public static bool updateStage(StageDTO pStage)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_update_stage", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_stage", SqlDbType.Int);
                command.Parameters["@id_stage"].Value = pStage.id_stage;
                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pStage.name;
                command.Parameters.Add("@stagePosition", SqlDbType.Int);
                command.Parameters["@stagePosition"].Value = pStage.stagePosition;
                command.Parameters.Add("@userLog", SqlDbType.Int);
                command.Parameters["@userLog"].Value = pStage.userLog;

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
        public static bool deleteParticipant(string id_template, string userLog, string user_id)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_process_participant", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_processManagment", SqlDbType.Int);
                command.Parameters["@id_processManagment"].Value = id_template;
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
        public static bool deleteStage(string id_stage, string userLog)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("usp_delete_stage", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_stage", SqlDbType.Int);
                command.Parameters["@id_stage"].Value = id_stage;
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
