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
        public string maxTaskPosition { get; set; }
        public AddTaskModel() { }
        public AddTaskModel(string id_stage, int maxTaskPosition)
        {
            taskTypes = taskProvider.getTaskTypes().Result;
            this.id_stage = id_stage;
            this.maxTaskPosition = maxTaskPosition.ToString();
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

        [Display(Name = "Cantidad")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeAmount { get; set; }

        [Display(Name = "Fecha")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeDatePicker { get; set; } 

        [Display(Name = "Tiempo")]
        [RegularExpression("^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]:[0-9][0-9]$",ErrorMessage = "Formato inválido")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeHour { get; set; }

        public string timeSelected { get; set; }
    }

    public class EditTaskInfo
    {
        public EditTaskInfo() { }
        public EditTaskInfo(TaskDTO task)
        {
            taskName = task.name;
            id_task = task.id_task;
        }
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string taskName { get; set; }

        [Required]
        public string id_task { get; set; }

    }
    //-------------------------------------- Responsables ---------------------------------------------
    public class TaskDetailsModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        private UsersProvider userProvider = new UsersProvider();
        public TaskDTO task;
        public UserDTO createdBy;
        public TaskStateDTO taskState;
        public TaskTypeDTO taskType;
        public TaskDetailsModel(string id_task)
        {
            task = taskProvider.getTask(id_task).Result;
            createdBy = userProvider.getUserbyID(task.createdBy).Result;
            taskState = taskProvider.getTaskState(task.taskState_id).Result;
            taskType = taskProvider.getTaskType(task.type_id).Result;
        }
    }
    public class TaskResponsablesModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        private ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();
        public List<TaskResponsableDTO> responsables = new List<TaskResponsableDTO>();
        public List<ParticipantDTO> userList = new List<ParticipantDTO>();
        public SelectList _ParticipantsSelect { get; set; }
        public string id_task;
        public TaskResponsablesModel() { }
        public TaskResponsablesModel(TaskDTO task)
        {
            this.id_task = task.id_task;
            responsables = taskProvider.getTaskResponsables(id_task).Result;
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
    public class AddResponsableModel
    {
        public AddResponsableModel() { }

        [Required]
        public string process_id { get; set; }

        [Display(Name = "Usuarios")]
        [Required(ErrorMessage = "Se debe seleccionar al menos un usuario")]
        public List<string> selected_userParticipants_id { get; set; }
    }
}
