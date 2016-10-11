using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Mvc;
using BeyondThemes.BeyondAdmin.Tools;
using System;
using Newtonsoft.Json;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    [ValidateLogin]
    public class TasksController : Controller
    {
        TemplatesProvider templateProvider = new TemplatesProvider();
        TaskProvider taskProvider = new TaskProvider();
        public ActionResult _TaskList(string id_stage)
        {
            return PartialView("/Views/Templates/_Tasks/_TasksList.cshtml", new Model.TasksModel(id_stage));
        }
        public ActionResult _TaskDetails(string id_task)
        {
            return PartialView("/Views/Templates/_Tasks/_TaskDetails.cshtml", new Model.TaskDetailsModel(id_task));
        }
        public ActionResult _AddGeneralInfo(string id_stage)
        {
            return PartialView("/Views/Templates/_Tasks/_AddTask/_AddAditionals.cshtml");
        }
        public ActionResult _AddResponsables(string id_stage)
        {
            return PartialView("/Views/Templates/_Tasks/_AddTask/_AddResponsables.cshtml");
        }
        public ActionResult _AddForm(string id_stage)
        {
            return PartialView("/Views/Templates/_Tasks/_AddTask/_AddForm.cshtml");
       } 
        public ActionResult _AddAditionals(string id_stage)
        {
            return PartialView("/Views/Templates/_Tasks/_AddTask/_AddAditionals.cshtml");
        }
        

        // -----------------------------------------------------------  Tasks ----------------------------------------------------------------
        [HttpPost]
        public ActionResult _AddTask(Model.AddTaskModel model)
        {
            if (ModelState.IsValid)
            {
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.name = model.name;
                taskDTO.description = model.description;
                taskDTO.stage_id = model.id_stage;
                taskDTO.type_id = model.selected_taskType; 
                taskDTO.taskPosition = model.maxTaskPosition;
                if (model.timeSelected == "days")
                {
                    taskDTO.daysAvailable = model.timeAmount;
                }
                else if(model.timeSelected == "date")
                {
                    taskDTO.finishDate = model.timeDatePicker.Substring(0,11) + model.timeHour;
                }
                else if (model.timeSelected == "hours")
                {
                    taskDTO.hoursAvailable = model.timeAmount;
                }
                taskDTO.userLog = Request.Cookies["user_id"].Value;
                string id_task;
                if ((id_task = taskProvider.postTask(taskDTO).Result) != null)
                {
                    var result = new { id_task = id_task, viewHtml = PartialView("/Views/Templates/_Tasks/_TasksList.cshtml", new Model.TasksModel(taskDTO.stage_id)).RenderToString() };
                    return Json(result);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        public ActionResult _EditTask(string id_task, string name = null, string taskPosition = null, string description = null, string taskState_id = null, string completedDate = null,
            string finishDate = null, string beginDate = null )
        {
            if (ModelState.IsValid)
            {
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.name = name;
                taskDTO.id_task = id_task;
                taskDTO.taskPosition = taskPosition;
                taskDTO.description = description;
                taskDTO.taskState_id = taskState_id;
                taskDTO.completedDate = completedDate;
                taskDTO.finishDate = finishDate;
                taskDTO.beginDate = beginDate;
                taskDTO.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTask(taskDTO).Result)
                {
                    return Content(name);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpDelete]
        public ActionResult _DeleteTask(string id_task)
        {
            if (taskProvider.deleteTask(id_task, Request.Cookies["user_id"].Value).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        // -----------------------------------------------------------  Tasks types ----------------------------------------------------------------
        [HttpGet]
        public ActionResult _GetTaskTypes()
        {
            List<TaskTypeDTO> taskTypes = taskProvider.getTaskTypes().Result;
            return Json(taskTypes, JsonRequestBehavior.AllowGet);
        }


        // -----------------------------------------------------------  Tasks responsables ----------------------------------------------------------------
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddTaskResponsableUser(string id_task, List<string> selected_userParticipants_id)
        {
            if (ModelState.IsValid)
            {
                List<TaskResponsableDTO> responsables = new List<TaskResponsableDTO>();
                foreach (var responsable_id in selected_userParticipants_id)
                {
                    TaskResponsableDTO taskResponsable = new TaskResponsableDTO();
                    taskResponsable.user_id = responsable_id;
                    taskResponsable.task_id = id_task;
                    taskResponsable.userLog = Request.Cookies["user_id"].Value;
                    responsables.Add(taskResponsable);
                }
                List<TaskResponsableDTO> adddedResponsables = taskProvider.postResponsableUser(responsables).Result;
                int addedCount = adddedResponsables.Count;
                int errorCount = responsables.Count - addedCount;
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.id_task = id_task;
                var result = new { usersAdded = addedCount, usersError = errorCount, viewHtml = PartialView("/Views/Templates/_Tasks/_TaskDetails/_TaskResponsablesList.cshtml", new Model.TaskResponsablesModel(taskDTO)).RenderToString() };
                return Json(result);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpPost]
        public ActionResult _AddTaskResponsableGroup(string id_task, string group_id)
        {
            if (ModelState.IsValid)
            {
                TaskResponsableDTO taskResponsable = new TaskResponsableDTO();
                taskResponsable.user_id = group_id;
                taskResponsable.task_id = id_task;
                taskResponsable.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.postResponsableGroup(taskResponsable).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpPut]
        public ActionResult _EditTaskResponsable(string id_task, string id_user, string isConfirmed)
        {
            if (ModelState.IsValid)
            {
                TaskResponsableDTO taskResponsable = new TaskResponsableDTO();
                taskResponsable.user_id = id_user;
                taskResponsable.task_id = id_task;
                taskResponsable.isConfirmed = isConfirmed;
                taskResponsable.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTaskResponsable(taskResponsable).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpDelete]
        public ActionResult _DeleteTaskResponsableUser(string id_task, string user_id)
        {
            if (taskProvider.deleteTaskResponsable(id_task, user_id, Request.Cookies["user_id"].Value).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
    }
}