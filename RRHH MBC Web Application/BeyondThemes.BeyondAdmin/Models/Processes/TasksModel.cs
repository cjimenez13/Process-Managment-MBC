using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Model
{
    public class TasksModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public List<TaskDTO> tasks = new List<TaskDTO>();
        public string id_stage;
        public TasksModel(string id_stage)
        {
            this.id_stage = id_stage;
            tasks = taskProvider.getTasks(id_stage).Result;
            foreach (var task in tasks)
            {
                int stagePosition = Int32.Parse(task.taskPosition);
                if (stagePosition >= maxStagePosition)
                {
                    maxStagePosition = stagePosition + 1;
                }
            }
        }
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        public string name { get; set; }
        public int maxStagePosition { get; set; } = 0;
    }
    public class AddTaskModel
    {
        private TaskProvider taskProvider = new TaskProvider();
        public List<TaskTypeDTO> taskTypes = new List<TaskTypeDTO>();
        public SelectList _TaskTypesSelect { get; set; }
        public AddTaskModel() { }
        public AddTaskModel(string id_stage)
        {
            taskTypes = taskProvider.getTaskTypes().Result;
            this.id_stage = id_stage;
            List<SelectListItem> taskSelectList = new List<SelectListItem>();
            foreach (TaskTypeDTO iTask in taskTypes)
            {
                taskSelectList.Add(new SelectListItem { Text = iTask.taskName, Value = iTask.id_taskType });
            }
            _TaskTypesSelect = new SelectList(taskSelectList, "Value", "Text");
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
        [Required(ErrorMessage = "Se debe completar el campo de cantidad/fecha")]
        [StringLength(20, ErrorMessage = "La cantidad máxima de caracteres es 20")]
        public string timeType { get; set; }


        [Display(Name = "Tiempo")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeAmount { get; set; }

        [Display(Name = "Tiempo")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeDate { get; set; }

        [Display(Name = "Tiempo")]
        [Required(ErrorMessage = "Se debe completar el campo de tiempo")]
        public string timeHour { get; set; }
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
}
