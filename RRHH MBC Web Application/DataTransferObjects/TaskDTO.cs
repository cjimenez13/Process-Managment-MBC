

namespace DataTransferObjects
{
    public class TaskDTO
    {
        public string id_task { get; set; }
        public string stage_id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string type_id { get; set; }
        public string taskState_id { get; set; }
        public string completedDate { get; set; }
        public string createdBy { get; set; }
        public string finishDate { get; set; }
        public string taskPosition { get; set; }
        public string createdDate { get; set; }
        public string beginDate { get; set; }
        public string userLog { get; set; }
    }

    public class TaskTypeDTO
    {
        public string id_taskType { get; set; }
        public string taskName{ get; set; }
        public string needConfirm { get; set; }
        public string formNeeded { get; set; }
    }

    public class TaskStateDTO
    {
        public string id_taskState { get; set; }
        public string state_name { get; set; }
        public string state_color { get; set; }
    }
}
