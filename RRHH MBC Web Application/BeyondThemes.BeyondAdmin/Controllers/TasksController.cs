using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Mvc;
using BeyondThemes.BeyondAdmin.Tools;
using System;

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
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult _AddTask(Model.AddTaskModel model)
        {
            if (ModelState.IsValid)
            {
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.name = model.name;
                taskDTO.description = model.description;
                string finishDate = "";
                if (model.timeType == "Day")
                {
                    finishDate = DateTime.Now.AddDays(Int32.Parse(model.timeAmount)).ToString();
                }
                else if(model.timeType == "Date")
                {
                    finishDate = model.timeDate;
                }
                else if (model.timeType == "Hours")
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
    }
}