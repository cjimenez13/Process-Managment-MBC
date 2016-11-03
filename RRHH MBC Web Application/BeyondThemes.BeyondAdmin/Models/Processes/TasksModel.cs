using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Model
{
    //-------------------------------------- Tasks ---------------------------------------------
    public class TasksModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        private ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();
        public List<TaskDTO> tasks = new List<TaskDTO>();
        public List<TaskStateDTO> taskStates;
        public StageDTO stage;
        public TasksModel(string id_stage)
        {
            this.stage = processManagmentProvider.getStage(id_stage).Result;
            tasks = taskProvider.getTasks(stage.id_stage).Result;
            foreach (var task in tasks)
            {
                int stagePosition = Int32.Parse(task.taskPosition);
                if (stagePosition >= maxTaskPosition)
                {
                    maxTaskPosition = stagePosition + 1;
                }
            }
            taskStates = taskProvider.getTaskStates().Result;

        }
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        public string name { get; set; }
        public int maxTaskPosition { get; set; } = 0;
    }
    public class AddTaskModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public List<TaskTypeDTO> taskTypes = new List<TaskTypeDTO>();
        public SelectList _TaskTypesSelect { get; set; }
        public string taskPosition { get; set; }
        public AddTaskModel() { }
        public AddTaskModel(string id_stage, int taskPosition)
        {
            taskTypes = taskProvider.getTaskTypes().Result;
            this.id_stage = id_stage;
            this.taskPosition = taskPosition.ToString();
            List<SelectListItem> taskSelectList = new List<SelectListItem>();
            foreach (TaskTypeDTO iTask in taskTypes)
            {
                taskSelectList.Add(new SelectListItem { Text = iTask.taskName, Value = iTask.id_taskType });
            }
            _TaskTypesSelect = new SelectList(taskSelectList, "Value", "Text");
            DateTime dt = DateTime.Parse(DateTime.Now.ToString());
            timeHour = dt.ToString("H:mm:ss");
            timeDatePicker = DateTime.Now.Date.ToString().Substring(0,10).Replace("/","-");
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string name { get; set; }

        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo de la descripción")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string description { get; set; }

        public string id_stage { get; set; }

        [Display(Name = "Tipo")]
        [Required(ErrorMessage = "Se debe completar el campo del tipo de categoría")]
        public string selected_taskType { get; set; }

        [Display(Name = "Horas")]
        [Required(ErrorMessage = "Se debe completar el campo de horas")]
        [Range(0, 24, ErrorMessage = "Ingresar solo numeros entre 0 y 24" )]
        public string hoursAmount { get; set; }

        [Display(Name = "Días")]
        [Required(ErrorMessage = "Se debe completar el campo de días")]
        public string daysAmount { get; set; }

        [Display(Name = "Fecha")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeDatePicker { get; set; } 

        [Display(Name = "Tiempo")]
        [RegularExpression("^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]:[0-9][0-9]$",ErrorMessage = "Formato inválido")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeHour { get; set; }

        public string timeSelected { get; set; }
    }

    public class UserTasksModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public List<TaskDTO> tasks;
        public List<TaskStateDTO> taskStates;
        public UserTasksModel(string user_id)
        {
            tasks = taskProvider.getTasksbyUser(user_id).Result;
            taskStates = taskProvider.getTaskStates().Result;
        }
    }
    public class EditTaskInfo
    {
        public EditTaskInfo() { }
        public EditTaskInfo(TaskDTO task)
        {
            nameE = task.name;
            id_taskE = task.id_task;
            descriptionE = task.description;
            hoursAvailableE = task.hoursAvailable;
            daysAvailableE = task.daysAvailable;

            DateTime dt = DateTime.Parse(DateTime.Now.ToString());
            finishDateE = task.finishDate != null && (task.finishDate != "") ? task.finishDate.Substring(0, 10) : DateTime.Now.Date.ToString().Substring(0, 10).Replace("/", "-"); ;
            finishTimeE = task.finishDate != null && (task.finishDate != "") ? task.finishDate.Substring(11) : dt.ToString("H:mm:ss"); ;
        }
        [Required]
        public string id_taskE { get; set; }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string nameE { get; set; }

        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo de la descripción")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string descriptionE { get; set; }

        [Display(Name = "Horas")]
        [Required(ErrorMessage = "Se debe completar el campo de horas")]
        public string hoursAvailableE { get; set; }

        [Display(Name = "Días")]
        [Required(ErrorMessage = "Se debe completar el campo de días")]
        public string daysAvailableE { get; set; }

        [Display(Name = "Fecha")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string finishDateE { get; set; }

        [Display(Name = "Tiempo")]
        [RegularExpression("^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]:[0-9][0-9]$", ErrorMessage = "Formato inválido")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string finishTimeE { get; set; }

        public string timeSelectedE { get; set; }
    }

    public class EditTaskCreeated
    {
        public EditTaskCreeated() { }
        public EditTaskCreeated(TaskDTO task)
        {
            name = task.name;
            id_task = task.id_task;
        }
        [Required]
        public string id_task { get; set; }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string name { get; set; }

        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo de la descripción")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string description { get; set; }

        public string id_stage { get; set; }

        [Display(Name = "Horas")]
        [Required(ErrorMessage = "Se debe completar el campo de horas")]
        public string hoursAmount { get; set; }

        [Display(Name = "Días")]
        [Required(ErrorMessage = "Se debe completar el campo de días")]
        public string daysAmount { get; set; }

        [Display(Name = "Fecha")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeDatePicker { get; set; }

        [Display(Name = "Tiempo")]
        [RegularExpression("^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]:[0-9][0-9]$", ErrorMessage = "Formato inválido")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeHour { get; set; }

        public string timeSelected { get; set; }

        public string taskPosition { get; set; }
    }
    public class TaskDetailsModel
    {
        public TaskProvider taskProvider = new TaskProvider();
        private UsersProvider userProvider = new UsersProvider();
        private ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();

        public TaskResponsablesModel taskResponsablesModel;
        public FormQuestionsModel formQuestionsModel;
        public TaskDTO task;
        public UserDTO createdBy;
        public TaskStateDTO taskState;
        public TaskTypeDTO taskType;
        public StageDTO stageDTO;
        public TaskDetailsModel(string id_task)
        {
            task = taskProvider.getTask(id_task).Result;
            this.stageDTO = processManagmentProvider.getStage(task.stage_id).Result;
            createdBy = userProvider.getUserbyID(task.createdBy).Result;
            taskState = taskProvider.getTaskState(task.taskState_id).Result;
            taskType = taskProvider.getTaskType(task.type_id).Result;
            if (taskType.needConfirm == "True")
            {
                taskResponsablesModel = new TaskResponsablesModel(task);
            }
            if (taskType.formNeeded == "True")
            {
                formQuestionsModel = new FormQuestionsModel(task);
            }
        }
    }
    //-------------------------------------- Responsables ---------------------------------------------
    public class TaskResponsablesModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        private ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();
        public List<TaskResponsableDTO> responsables = new List<TaskResponsableDTO>();
        public List<ParticipantDTO> userList = new List<ParticipantDTO>();
        public SelectList _ParticipantsSelect { get; set; }
        public TaskDTO task;
        public TaskResponsablesModel() { }
        public TaskResponsablesModel(TaskDTO task)
        {
            this.task = task;
            responsables = taskProvider.getTaskResponsables(task.id_task).Result;
            this.process_id = process_id;
            userList = taskProvider.getTaskParticipants(task.id_task).Result;
            List<SelectListItem> usersSelectList = new List<SelectListItem>();
            foreach (ParticipantDTO iUser in userList)
            {
                var name = iUser.name + " " + iUser.fLastName + " " + iUser.sLastName;
                usersSelectList.Add(new SelectListItem { Text = name, Value = iUser.user_id });
            }
            _ParticipantsSelect = new SelectList(usersSelectList, "Value", "Text");
        }
        [Required]
        public string process_id { get; set; }
        [Display(Name = "Usuarios")]
        [Required(ErrorMessage = "Se debe seleccionar al menos un usuario")]
        public List<string> selected_userParticipants_id { get; set; }
    }

    //-------------------------------------- Forms ---------------------------------------------
    public class EditTaskForm
    {
        private TaskProvider taskProvider = new TaskProvider();
        public TaskFormDTO taskFormDTO;

        public EditTaskForm() { }
        public EditTaskForm(TaskFormDTO taskForm)
        {
            this.taskFormDTO = taskForm;
            this.description = taskFormDTO.description;
            this.id_taskForm = taskFormDTO.id_taskForm;
        }

        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo de la descripción")]
        [StringLength(300, ErrorMessage = "La cantidad máxima de caracteres es 300")]
        public string description { get; set; }

        public string id_taskForm { get; set; }

    }
    public class AddFormUsersModel
    {
        public FormUsersModel formUsersModel;
        private TaskProvider taskProvider = new TaskProvider();
        public SelectList _ParticipantsSelect { get; set; }
        public List<ParticipantDTO> userList = new List<ParticipantDTO>();
        public TaskDTO taskDTO;
        public TaskFormDTO taskFormDTO;
        public AddFormUsersModel(TaskDTO taskDTO, TaskFormDTO taskFormDTO)
        {
            this.taskDTO = taskDTO;
            this.taskFormDTO = taskFormDTO;
            userList = taskProvider.getTaskParticipants(taskDTO.id_task).Result;
            this.taskForm_id = taskFormDTO.id_taskForm;
            List<SelectListItem> usersSelectList = new List<SelectListItem>();
            foreach (ParticipantDTO iUser in userList)
            {
                var name = iUser.name + " " + iUser.fLastName + " " + iUser.sLastName;
                usersSelectList.Add(new SelectListItem { Text = name, Value = iUser.user_id });
            }
            _ParticipantsSelect = new SelectList(usersSelectList, "Value", "Text");
            formUsersModel = new FormUsersModel(taskFormDTO.id_taskForm);
        }
        public string taskForm_id;
        [Display(Name = "Usuarios")]
        [Required(ErrorMessage = "Se debe seleccionar al menos un usuario")]
        public List<string> selected_userForm_id { get; set; }
    }
    public class FormUsersModel
    {
        public List<TaskFormUserDTO> formUsers;
        private TaskProvider taskProvider = new TaskProvider();
        public string taskForm_id;

        public FormUsersModel(string taskForm_id)
        {
            this.taskForm_id = taskForm_id;
            formUsers = taskProvider.getFormUsers(taskForm_id).Result;

        }
    }
    public class FormQuestionsModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public List<QuestionTypeDTO> questionsTypes = new List<QuestionTypeDTO>();
        public List<AttributeDTO> attributes = new List<AttributeDTO>();
        public TaskFormDTO taskForm = new TaskFormDTO();
        public AddFormUsersModel addFormUsersModel;
        public List<TaskQuestionDTO> formQuestions = new List<TaskQuestionDTO>();
        public SelectList _QuestionTypesSelect { get; set; }
        public SelectList _AttributesSelect { get; set; }
        public TaskDTO taskDTO;
        public FormQuestionsModel(){ }
        public FormQuestionsModel(TaskDTO taskDTO)
        {
            //-- Get questions
            this.taskDTO = taskDTO;
            taskForm = taskProvider.getTaskForm(this.taskDTO.id_task).Result;
            if (taskForm.id_taskForm != null)
            {
                formQuestions = taskProvider.getFormQuestions(taskForm.id_taskForm).Result;
            }
            this.id_taskFormA = taskForm.id_taskForm;
            this.id_taskA = taskDTO.id_task;
            _QuestionTypesSelect = generateQuestionTypesSelect();
            _AttributesSelect = generateAttributeTypesSelect();
            //-- Max position
            foreach (var question in formQuestions)
            {
                int questionPosition = Int32.Parse(question.questionPosition);
                if (questionPosition >= maxQuestionPositionA)
                {
                    maxQuestionPositionA = questionPosition + 1;
                }
            }
            addFormUsersModel = new AddFormUsersModel(taskDTO, taskForm);
        }
        private SelectList generateQuestionTypesSelect()
        {
            questionsTypes = taskProvider.getQuestionTypes().Result;
            List<SelectListItem> _TypeSelectList = new List<SelectListItem>();
            foreach (QuestionTypeDTO iType in questionsTypes)
            {
                _TypeSelectList.Add(new SelectListItem { Text = iType.name, Value = iType.id_questionType });
            }
            return new SelectList(_TypeSelectList, "Value", "Text");
        }
        private SelectList generateAttributeTypesSelect()
        {
            List<SelectListItem> _AttributeListSelectList = new List<SelectListItem>();
            attributes = taskProvider.getTaskAttributes(taskDTO.id_task).Result;
            foreach (AttributeDTO iAttribute in attributes)
            {
                if (iAttribute.type_id == "4")
                {
                    _AttributeListSelectList.Add(new SelectListItem { Text = iAttribute.name, Value = iAttribute.id_attribute });
                }
            }
            return new SelectList(_AttributeListSelectList, "Value", "Text");
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(250, ErrorMessage = "La cantidad máxima de caracteres es 250")]
        public string questionA { get; set; }
        public string selected_questionType_idA { get; set; }
        public string selected_attribute_idA { get; set; }
        public string id_taskFormA { get; set; }
        public string id_taskA { get; set; }
        public string isRequired { get; set; }
        public int maxQuestionPositionA { get; set; } = 0;
    }
    //-------------------------------------- Task Changes ---------------------------------------------
    public class TaskChangesModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public CategorieProvider categorieProvider = new CategorieProvider();
        public List<TaskChangeDTO> taskChanges;
        public TaskDTO taskDTO;
        public SelectList operationTypesList;
        public List<AttributeDTO> attributes;
        public List<OperationTypeDTO> operationTypes;
        public TaskChangesModel() { }
        public TaskChangesModel(TaskDTO taskDTO)
        {
            this.taskDTO = taskDTO;
            taskChanges = taskProvider.getTaskChanges(taskDTO.id_task).Result;
            this.task_idA = this.taskDTO.id_task;
            attributes = taskProvider.getTaskAttributes(this.task_idA).Result;
            operationTypes = taskProvider.getOperationTypes().Result;
            operationTypesList = generateOperationTypesList();
        }
        private SelectList generateOperationTypesList()
        {
            List<SelectListItem> _OperationTypesListSelectList = new List<SelectListItem>();
            foreach (OperationTypeDTO iOperationType in operationTypes)
            {
                _OperationTypesListSelectList.Add(new SelectListItem { Text = iOperationType.displayName, Value = iOperationType.id_operationType });
            }
            return new SelectList(_OperationTypesListSelectList, "Value", "Text");
        }
        public string id_taskChangeA { get; set; }
        public string task_idA { get; set; }
        [Required]
        public string attribute_idA { get; set; }
        [Required]
        public string operation_idA { get; set; }
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string valueA { get; set; }
        public string attributeList_typeA { get; set; }
        public string attribute_typeA { get; set; }
    }
    public class EditTaskChangeModel
    {

        public string attributeList_type { get; set; }
        public string attribute_type { get; set; }
        public string id_taskChange { get; set; }
        [Required]
        public string attribute_id { get; set; }
        [Required]
        public string operation_id { get; set; }
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string value { get; set; }
    }
    //-------------------------------------- Task Files ---------------------------------------------
    public class TaskFilesModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public List<FileTaskDTO> files;
        public TaskDTO taskDTO;
        public TaskFilesModel(TaskDTO pTaskDTO)
        {
            taskDTO = pTaskDTO;
            files = taskProvider.getTaskFiles(taskDTO.id_task).Result;
        }
    }
    public class AddTaskFileModel
    {
        public AddTaskFileModel() { }
        public AddTaskFileModel(string id_task)
        {
            this.id_task = id_task;
        }
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }
        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo de la descripción")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string description { get; set; }
        public string id_task { get; set; }
    }

    //-------------------------------------- Task Notifications ---------------------------------------------
    public class TaskNotificationsModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public List<TaskNotificationDTO> notifications;
        public TaskDTO taskDTO;
        public TaskNotificationsModel(TaskDTO pTaskDTO)
        {
            taskDTO = pTaskDTO;
            notifications = taskProvider.getTaskNotifications(taskDTO.id_task).Result;
        }
    }
    public class AddTaskNotificationModel
    {
        public AddTaskNotificationModel() { }
        public AddTaskNotificationModel(string id_task)
        {
            this.id_task = id_task;
        }

        [Display(Name = "Mensaje")]
        [Required(ErrorMessage = "Se debe completar el campo del mensaje")]
        [StringLength(2000, ErrorMessage = "La cantidad máxima de caracteres es 2000")]
        public string message { get; set; }
        [Required]
        public string id_task { get; set; }
        public string isTelegram { get; set; }
        public string isIntern { get; set; }
        public string isEmail { get; set; }

    }
    public class EditTaskNoficationModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public List<TaskNotificationDTO> notifications;
        public TaskNotificationDTO taskNoficationDTO;
        public List<ParticipantDTO> userList = new List<ParticipantDTO>();
        public SelectList _ParticipantsSelect { get; set; }
        public TaskDTO taskDTO;
        public EditTaskNoficationModel(TaskNotificationDTO taskNoficationDTO, TaskDTO pTaskDTO)
        {
            taskDTO = pTaskDTO;
            this.taskNoficationDTO = taskNoficationDTO;
            this.message = taskNoficationDTO.message;
            this.id_notification = taskNoficationDTO.id_notification;
            this.isTelegram = taskNoficationDTO.isTelegram;
            this.isIntern = taskNoficationDTO.isIntern;
            this.isEmail = taskNoficationDTO.isEmail;
            userList = taskProvider.getTaskParticipants(taskDTO.id_task).Result;
            List<SelectListItem> usersSelectList = new List<SelectListItem>();
            foreach (ParticipantDTO iUser in userList)
            {
                var name = iUser.name + " " + iUser.fLastName + " " + iUser.sLastName;
                usersSelectList.Add(new SelectListItem { Text = name, Value = iUser.user_id });
            }
            _ParticipantsSelect = new SelectList(usersSelectList, "Value", "Text");
        }

        public List<string> selected_userParticipants_id { get; set; }
        [Display(Name = "Mensaje")]
        [Required(ErrorMessage = "Se debe completar el campo del mensaje")]
        [StringLength(2000, ErrorMessage = "La cantidad máxima de caracteres es 2000")]
        public string message { get; set; }
        [Required]
        public string id_notification { get; set; }
        public string isTelegram { get; set; }
        public string isIntern { get; set; }
        public string isEmail { get; set; }
    }
    public class TaskNotificationsUserModel
    {
        public List<TaskNotificationUserDTO> users;
        private TaskProvider taskProvider = new TaskProvider();
        public TaskNotificationDTO taskNoficationDTO;

        public TaskNotificationsUserModel(TaskNotificationDTO taskNoficationDTO)
        {
            this.taskNoficationDTO = taskNoficationDTO;
            this.users = taskProvider.getTaskNotificationUsers(taskNoficationDTO.id_notification).Result;
        }
    }

}
