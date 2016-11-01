

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
        public string daysAvailable { get; set; }
        public string hoursAvailable { get; set; }
        public string isProcess { get; set; }
        public string process_name { get; set; }
        public string userLog { get; set; }
    }

    public class TaskTypeDTO
    {
        public string id_taskType { get; set; }
        public string taskName { get; set; }
        public string needConfirm { get; set; }
        public string formNeeded { get; set; }
    }

    public class TaskStateDTO
    {
        public string id_taskState { get; set; }
        public string state_name { get; set; }
        public string state_color { get; set; }
        public string state_sColor { get; set; }
    }
    public class TaskResponsableDTO
    {
        public string task_id { get; set; }
        public string user_id { get; set; }
        public string isConfirmed { get; set; }
        public string name { get; set; }
        public string sLastName { get; set; }
        public string fLastName { get; set; }
        public string userName { get; set; }
        public string email { get; set; }
        public string photoData { get; set; }
        public string userLog { get; set; }
    }
    public class TaskQuestionDTO
    {
        public string id_taskQuestion { get; set; }
        public string taskForm_id { get; set; }
        public string question { get; set; }
        public string isRequired { get; set; }
        public string generalAttributeList { get; set; }
        public string questionType_id { get; set; }
        public string userLog { get; set; }
        public string questionPosition { get; set; }
    }
    public class QuestionTypeDTO
    {
        public string id_questionType { get; set; }
        public string name { get; set; }
    }
    public class TaskFormDTO
    {
        public string id_taskForm { get; set; }
        public string id_task { get; set; }
        public string description { get; set; }
        public string userLog { get; set; }
    }
    public class TaskChangeDTO
    {
        public string id_taskChange { get; set; }
        public string task_id { get; set; }
        public string attribute_id { get; set; }
        public string attributeList_id { get; set; }
        public string operation_id { get; set; }
        public string value { get; set; }
        public string attributeList_type { get; set; }
        public string attribute_type { get; set; }
        public string userLog { get; set; }
    }
    public class OperationTypeDTO
    {
        public string id_operationType { get; set; }
        public string displayName { get; set; }
        public string operation { get; set; }
        public string reg_expr { get; set; }
    }
    public class FileTaskDTO
    {
        public byte[] fileData { get; set; }
        public string task_id { get; set; }
        public string name { get; set; }
        public string createdDate { get; set; }
        public string fileBase64 { get; set; }
        public string description { get; set; }
        public string id_taskFile { get; set; }
        public string fileType { get; set; }
        public string fileName { get; set; }
        public string userLog { get; set; }
    }
    public class TaskNotificationDTO
    {
        public string id_notification { get; set; }
        public string task_id { get; set; }
        public string message { get; set; }
        public string isStarting { get; set; }
        public string isTelegram { get; set; }
        public string isIntern { get; set; }
        public string isEmail { get; set; }
        public string userLog { get; set; }
    }
    public class TaskNotificationTypeDTO
    {
        public string notification_id { get; set; }
        public string type_id { get; set; }
        public string isSended { get; set; }
        public string type_name { get; set; }
        public string userLog { get; set; }
    }
    public class TaskNotificationUserDTO
    {
        public string notification_id { get; set; }
        public string user_id { get; set; }
        public string name { get; set; }
        public string sLastName { get; set; }
        public string fLastName { get; set; }
        public string userName { get; set; }
        public string email { get; set; }
        public string photoData { get; set; }
        public string userLog { get; set; }
    }
    public class TaskFormUserDTO
    {
        public string taskForm_id { get; set; }
        public string user_id { get; set; }
        public string isAnswered { get; set; }
        public string name { get; set; }
        public string sLastName { get; set; }
        public string fLastName { get; set; }
        public string userName { get; set; }
        public string email { get; set; }
        public string photoData { get; set; }
        public string userLog { get; set; }
    }

    public class TaskQuestionAnswerDTO
    {
        public string question { get; set; }
        public string questionPosition { get; set; }
        public string questionType_id { get; set; }
        public string questionType_name { get; set; }
        public string taskQuestion_id { get; set; }
        public string user_id { get; set; }
        public string answered_date { get; set; }
        public string response { get; set; }
        public byte[] responseData { get; set; }
        public string userLog { get; set; }
    }
}
