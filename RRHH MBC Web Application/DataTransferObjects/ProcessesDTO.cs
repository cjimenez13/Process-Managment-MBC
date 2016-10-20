namespace DataTransferObjects
{
    public class ProcessDTO
    {
        public string id_processManagment { get; set; }
        public string name { get; set; }
        public string createdDate { get; set; }
        public string createdBy { get; set; }
        public string state_id { get; set; }
        public string state_name { get; set; }
        public string state_color { get; set; }
        public string categorie_id { get; set; }
        public string categorie_name { get; set; }
        public string template_id { get; set; }
        public string template_name { get; set; }
        public string completedPorcentage { get; set; }
        public string nextProcess { get; set; }
        public string previousProcess { get; set; }
        public string userLog { get; set; }
    }
    public class StageDTO
    {
        public string id_stage { get; set; }
        public string name { get; set; }
        public string processManagment_id { get; set; }
        public string stagePosition { get; set; }
        public string createdBy { get; set; }
        public string createdDate { get; set; }
        public string isCompleted { get; set; }
        public string userLog { get; set; }
    }

    public class ParticipantDTO
    {
        public string processManagment_id { get; set; }
        public string user_id { get; set; }
        public string name { get; set; }
        public string sLastName { get; set; }
        public string fLastName { get; set; }
        public string userName { get; set; }
        public string email { get; set; }
        public string photoData { get; set; }
        public string userLog { get; set; }
    }
}
