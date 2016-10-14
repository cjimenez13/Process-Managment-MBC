using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Mvc;
using BeyondThemes.BeyondAdmin.Tools;
using System;
using Newtonsoft.Json;
using System.IO;
using System.Text.RegularExpressions;

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
        public ActionResult _AddResponsables(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Templates/_Tasks/_TaskDetails/_TaskResponsables.cshtml", new Model.TaskResponsablesModel(task));
        }
        public ActionResult _AddForm(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Templates/_Tasks/_TaskDetails/_TaskForm.cshtml", new Model.FormQuestionsModel(task));
       }
        public ActionResult _AddAditionals(string id_task)
        {
            return PartialView("/Views/Templates/_Tasks/_TaskDetails/_TaskAdditionals.cshtml");
        }
        public ActionResult _AddTaskChanges(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Templates/_Tasks/_TaskDetails/_TaskDataChanges.cshtml", new Model.TaskChangesModel(task));
        }
        public ActionResult _TaskQuestions(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Templates/_Tasks/_TaskDetails/_TaskQuestions.cshtml", new Model.FormQuestionsModel(task));
        }
        public ActionResult _TaskDataChangesList(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Templates/_Tasks/_TaskDetails/_TaskDataChangesList.cshtml", new Model.TaskChangesModel(task));
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
                    id_task = id_task.Replace("\"","");
                    bool isSuccess = false;
                    TaskTypeDTO taskType =taskProvider.getTaskType(taskDTO.type_id).Result;
                    if (taskType.formNeeded == "True")
                    {
                        TaskFormDTO taskForm = new TaskFormDTO();
                        taskForm.id_task = id_task;
                        taskForm.description = "";
                        taskForm.userLog = taskDTO.userLog;
                        if (taskProvider.postTaskForm(taskForm).Result)
                        {
                            isSuccess = true;
                        }
                    }
                    else
                    {
                        isSuccess = true;
                    }
                    if (isSuccess)
                    {
                        var result = new { id_task = id_task, viewHtml = PartialView("/Views/Templates/_Tasks/_TasksList.cshtml", new Model.TasksModel(taskDTO.stage_id)).RenderToString() };
                        return Json(result);
                    }
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
        [ValidateAntiForgeryToken]
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
        // -----------------------------------------------------------  Tasks form ----------------------------------------------------------------
        [HttpGet]
        public ActionResult _GetFormPDF()
        {
            byte[] file = PDFExporter.getPDF("");
            return File(file, "application/pdf", "form.pdf");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddTaskQuestion(Model.FormQuestionsModel pModel)
        {
            if (ModelState.IsValid)
            {
                TaskQuestionDTO taskQuestion = new TaskQuestionDTO();
                taskQuestion.question = pModel.questionA;
                taskQuestion.questionType_id = pModel.selected_questionType_idA;
                taskQuestion.taskForm_id = pModel.id_taskFormA;
                taskQuestion.questionPosition = pModel.maxQuestionPositionA.ToString();
                taskQuestion.isRequired = pModel.isRequired == "on" ? "True": "False";
                if (taskQuestion.questionType_id == "3")
                {
                    taskQuestion.generalAttributeList = pModel.selected_attribute_idA;
                }
                taskQuestion.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.postFormQuestion(taskQuestion).Result)
                {
                    return _TaskQuestions(pModel.id_taskA);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpPut]
        public ActionResult _EditFormQuestion( string id_taskQuestion, string question = null, string questionType_id = null, string attribute_id = null, string questionPosition = null, string isRequired = null)
        {
            if (ModelState.IsValid)
            {
                TaskQuestionDTO taskQuestionDTO = new TaskQuestionDTO();
                taskQuestionDTO.id_taskQuestion = id_taskQuestion;
                taskQuestionDTO.question = question;
                taskQuestionDTO.questionType_id = questionType_id;
                taskQuestionDTO.generalAttributeList = attribute_id;
                taskQuestionDTO.questionPosition = questionPosition;
                taskQuestionDTO.isRequired = isRequired == "on" ? "True" : "False";
                taskQuestionDTO.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putFormQuestion(taskQuestionDTO).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpDelete]
        public ActionResult _DeleteFormQuestion(string id_formQuestion)
        {
            if (taskProvider.deleteFormQuestion(id_formQuestion, Request.Cookies["user_id"].Value).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        public ActionResult _EditTaskForm(string id_taskForm, string description)
        {
            if (ModelState.IsValid)
            {
                TaskFormDTO taskForm = new TaskFormDTO();
                taskForm.id_taskForm = id_taskForm;
                taskForm.description = description;
                taskForm.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTaskForm(taskForm).Result)
                {
                    return Json(taskForm);
                }
            }
            else
            {
                return new HttpStatusCodeResult(404, "El campo descripción es incorreccto");
            }
            return new HttpStatusCodeResult(404, "Error, no se puede editar el formulario");
        }
        // -----------------------------------------------------------  Tasks Data changes ----------------------------------------------------------------
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddTaskChange(Model.TaskChangesModel pModel)
        {
            if (ModelState.IsValid)
            {
                CategorieProvider categorieProvider = new CategorieProvider();
                TaskChangeDTO taskChange = new TaskChangeDTO();
                taskChange.task_id = pModel.task_idA;
                AttributeTypeDTO typeDTO;
                if (pModel.attribute_idA.Substring(0,1) == "l")
                {
                    taskChange.attributeList_id = pModel.attribute_idA.Substring(1);
                    AttributeListDTO attributeListDTO = categorieProvider.getAttributeList(taskChange.attributeList_id).Result;
                    typeDTO = categorieProvider.getAttributeType(attributeListDTO.type_id).Result;
                }
                else
                {
                    taskChange.attribute_id = pModel.attribute_idA.Substring(1);
                    GeneralAttributeDTO generalAttributeDTO = categorieProvider.getGeneralAttribute(taskChange.attribute_id).Result;
                    typeDTO = categorieProvider.getAttributeType(generalAttributeDTO.type_id).Result;
                }
                if (!(typeDTO.reg_expr == "" || new Regex(typeDTO.reg_expr).Match(pModel.valueA).Success))
                {
                    return new HttpStatusCodeResult(404, "Error, el campo valor debe ser de tipo: " + typeDTO.type);
                }
                taskChange.operation_id = pModel.operation_idA;
                taskChange.value = pModel.valueA.ToString();
                taskChange.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.postTaskChange(taskChange).Result)
                {
                    return _TaskDataChangesList(taskChange.task_id);
                }
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar el cambio de dato");
        }

        [HttpPut]
        [ValidateAntiForgeryToken]
        public ActionResult _EditTaskChange(Model.EditTaskChangeModel pModel)
        {
            if (ModelState.IsValid)
            {
                CategorieProvider categorieProvider = new CategorieProvider();
                TaskChangeDTO taskChange = new TaskChangeDTO();
                taskChange.id_taskChange = pModel.id_taskChange;
                AttributeTypeDTO typeDTO;
                if (pModel.attribute_id.Substring(0, 1) == "l")
                {
                    taskChange.attributeList_id = pModel.attribute_id.Substring(1);
                    typeDTO = categorieProvider.getAttributeType(pModel.attributeList_type).Result;
                }
                else
                {
                    taskChange.attribute_id = pModel.attribute_id.Substring(1);
                    typeDTO = categorieProvider.getAttributeType(pModel.attribute_type).Result;
                }
                if (!(typeDTO.reg_expr == "" || new Regex(typeDTO.reg_expr).Match(pModel.value).Success))
                {
                    return new HttpStatusCodeResult(404, "Error, el campo valor debe ser de tipo: "+typeDTO.type);
                }
                taskChange.operation_id = pModel.operation_id;
                taskChange.value = pModel.value.ToString();
                taskChange.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTaskChange(taskChange).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Error, no se puede editar el cambio de dato");
        }

        [HttpDelete]
        public ActionResult _DeleteTaskChange(string id_taskChange)
        {
            if (ModelState.IsValid)
            {
                if (taskProvider.deleteTaskChange(id_taskChange, Request.Cookies["user_id"].Value).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
    }
}