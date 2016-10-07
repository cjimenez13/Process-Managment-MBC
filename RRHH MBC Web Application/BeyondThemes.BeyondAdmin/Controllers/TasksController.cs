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
                string finishDate = "";
                if (model.timeSelected == "days")
                {
                    finishDate = DateTime.Now.AddDays(Int32.Parse(model.timeAmount)).ToString();
                }
                else if(model.timeSelected == "date")
                {
                    finishDate = model.timeDatePicker;
                }
                else if (model.timeSelected == "hours")
                {
                    finishDate = DateTime.Now.AddDays(Int32.Parse(model.timeAmount)).ToString();
                }
                taskDTO.finishDate = finishDate;
                taskDTO.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.postTask(taskDTO).Result)
                {
                    return _TaskList(taskDTO.stage_id);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        [ValidateAntiForgeryToken]
        public ActionResult _EditTemplate(string name, string id_task)
        {
            if (ModelState.IsValid)
            {
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.name = name;
                taskDTO.id_task = id_task;
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
                return RedirectToAction("Index", "Templates");
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpGet]
        public ActionResult _GetTaskTypes()
        {
            List<TaskTypeDTO> taskTypes = taskProvider.getTaskTypes().Result;
            return Json(taskTypes, JsonRequestBehavior.AllowGet);
        }
    }
}