﻿using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Mvc;
using BeyondThemes.BeyondAdmin.Tools;
using System;
using Newtonsoft.Json;
using System.IO;
using System.Text.RegularExpressions;
using Model;
using System.Web;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    public class TasksController : Controller
    {
        TemplatesProvider templateProvider = new TemplatesProvider();
        TaskProvider taskProvider = new TaskProvider();
        [ValidateLogin]
        [Authorize]
        public ActionResult Index(string id)
        {
            TasksModel model = new TasksModel(id);
            if(model.stage.name != null)
                return View(model);
            else
                return View("/Views/Home/Error404.cshtml");
        }
        [Authorize]
        public ActionResult _TaskList(string id_stage)
        {
            return PartialView("/Views/Tasks/_Tasks/_TasksList.cshtml", new Model.TasksModel(id_stage));
        }
        [Authorize]
        public ActionResult _TaskDetails(string id_task)
        {
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails.cshtml", new Model.TaskDetailsModel(id_task));
        }
        [Authorize]
        public ActionResult _AddResponsables(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskResponsables.cshtml", new Model.TaskResponsablesModel(task));
        }
        [Authorize]
        public ActionResult _AddForm(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskForm.cshtml", new Model.FormQuestionsModel(task));
       }
        [Authorize]
        public ActionResult _AddAditionals(string id_task)
        {
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskAdditionals.cshtml", new TaskDetailsModel(id_task));
        }
        [Authorize]
        public ActionResult _AddTaskChanges(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskDataChanges.cshtml", new Model.TaskChangesModel(task));
        }
        [Authorize]
        public ActionResult _TaskQuestions(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskQuestions.cshtml", new Model.FormQuestionsModel(task));
        }
        [Authorize]
        public ActionResult _TaskDataChangesList(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskDataChangesList.cshtml", new Model.TaskChangesModel(task));
        }
        [Authorize]
        public ActionResult _TaskFilesList(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskFilesList.cshtml", new Model.TaskFilesModel(task));
        }
        [Authorize]
        public ActionResult _TaskNotificationList(string id_task)
        {
            TaskDTO task = new TaskDTO();
            task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskNotificationsList.cshtml", new Model.TaskNotificationsModel(task));
        }
        [Authorize]
        public ActionResult _TaskNotificationUsers(string id_notification)
        {
            TaskNotificationDTO taskNotification = new TaskNotificationDTO();
            taskNotification.id_notification = id_notification;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskNotificationUsers.cshtml", new Model.TaskNotificationsUserModel(taskNotification));
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
                taskDTO.taskPosition = model.taskPosition;
                if (model.timeSelected == "time")
                {
                    taskDTO.daysAvailable = model.daysAmount;
                    taskDTO.hoursAvailable = model.hoursAmount;
                }
                else if(model.timeSelected == "date")
                {
                    taskDTO.finishDate = model.timeDatePicker + " " + model.timeHour;
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
                        var result = new { id_task = id_task, viewHtml = PartialView("/Views/Tasks/_Tasks/_TasksList.cshtml", new Model.TasksModel(taskDTO.stage_id)).RenderToString() };
                        return Json(result);
                    }
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        public ActionResult _EditTaskCreated(Model.EditTaskCreeated model)
        {
            if (ModelState.IsValid)
            {
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.name = model.name;
                taskDTO.description = model.description;
                taskDTO.stage_id = model.id_stage;
                taskDTO.taskPosition = model.taskPosition;
                taskDTO.id_task = model.id_task;
                if (model.timeSelected == "time")
                {
                    taskDTO.daysAvailable = model.daysAmount;
                    taskDTO.hoursAvailable = model.hoursAmount;
                }
                else if (model.timeSelected == "date")
                {
                    taskDTO.finishDate = model.timeDatePicker.Substring(0, 11) + model.timeHour;
                }
                taskDTO.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTask(taskDTO).Result)
                {
                    return PartialView("/Views/Templates/_Tasks/_TasksList.cshtml", new Model.TasksModel(taskDTO.stage_id));
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        public ActionResult _EditTask(Model.EditTaskInfo model)
        {
            if (ModelState.IsValid)
            {
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.name = model.nameE;
                taskDTO.description = model.descriptionE;
                taskDTO.id_task = model.id_taskE;
                if (model.timeSelectedE == "time")
                {
                    taskDTO.daysAvailable = model.daysAvailableE;
                    taskDTO.hoursAvailable = model.hoursAvailableE;
                }
                else if (model.timeSelectedE == "date")
                {
                    taskDTO.finishDate = model.finishTimeE.Substring(0, 11) + model.finishDateE;
                }
                taskDTO.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTask(taskDTO).Result)
                {
                    return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskInfo.cshtml", new Model.TaskDetailsModel(taskDTO.id_task));
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
                var result = new { usersAdded = addedCount, usersError = errorCount, viewHtml = PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskResponsablesList.cshtml", new Model.TaskResponsablesModel(taskDTO)).RenderToString() };
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
        [HttpPost]
        public ActionResult UploadTaskFile(AddTaskFileModel model)
        {
            if (Request.Files.Count > 0)
            {
                try
                {
                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                        HttpPostedFileBase file = files[i];
                        string fname = file.FileName;
                        string fileName = Path.GetFileName(fname);
                        string fileExtension = Path.GetExtension(fileName).ToLower();
                        int fileSize = file.ContentLength;
                        Stream stream = file.InputStream;
                        BinaryReader binaryReader = new BinaryReader(stream);
                        byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
                        FileTaskDTO fileDTO = new FileTaskDTO();
                        fileDTO.fileData = bytes;
                        fileDTO.name = model.name;
                        fileDTO.description = model.description;
                        fileDTO.fileName = fileName;
                        fileDTO.fileType = file.ContentType;
                        fileDTO.task_id = model.id_task;
                        fileDTO.userLog = Request.Cookies["user_id"].Value;
                        if (taskProvider.postTaskFile(fileDTO).Result)
                        {
                            return _TaskFilesList(fileDTO.task_id);
                        }
                    }
                    return new HttpStatusCodeResult(404, "Error, el archivo no se puede cargar");
                }
                catch (Exception ex)
                {
                    return new HttpStatusCodeResult(404, "Error, el archivo no se puede cargar");
                }
            }
            else
            {
                return new HttpStatusCodeResult(404, "Error, No se selecciono ningun archivo");
            }
        }

        [HttpDelete]
        public ActionResult _DeleteTaskFile(string id_taskFile)
        {
            if (taskProvider.deleteTaskFile(id_taskFile, Request.Cookies["user_id"].Value).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        //-- Task Notifications

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddTaskNotification(Model.AddTaskNotificationModel pModel)
        {
            if (ModelState.IsValid)
            {
                TaskProvider taskProvider = new TaskProvider();
                TaskNotificationDTO taskNotification = new TaskNotificationDTO();
                taskNotification.task_id = pModel.id_task;
                taskNotification.message = pModel.message;
                taskNotification.userLog = Request.Cookies["user_id"].Value;
                taskNotification.isStarting = "False";
                taskNotification.isTelegram = pModel.isTelegram == "on" ? "True" : "False";
                taskNotification.isIntern = pModel.isIntern == "on" ? "True" : "False";
                taskNotification.isEmail = pModel.isEmail == "on" ? "True" : "False";

                if (taskProvider.postTaskNotification(taskNotification).Result)
                {
                    return _TaskNotificationList(taskNotification.task_id);
                }
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar la notificación");
        }
        [HttpDelete]
        public ActionResult _DeleteTaskNotification(string id_taskNotification)
        {
            if (ModelState.IsValid)
            {
                if (taskProvider.deleteTaskNotification(id_taskNotification, Request.Cookies["user_id"].Value).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar la notificación");
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddTaskNotificationUser(string id_notification, List<string> selected_userParticipants_id)
        {
            if (ModelState.IsValid)
            {
                TaskProvider taskProvider = new TaskProvider();
                List<TaskNotificationUserDTO> taskNotificationUsers = new List<TaskNotificationUserDTO>();
                foreach (var user_id in selected_userParticipants_id)
                {
                    TaskNotificationUserDTO taskNotificationUser = new TaskNotificationUserDTO();
                    taskNotificationUser.user_id = user_id;
                    taskNotificationUser.userLog = Request.Cookies["user_id"].Value;
                    taskNotificationUser.notification_id = id_notification;
                    taskNotificationUsers.Add(taskNotificationUser);
                }

                List<TaskNotificationUserDTO> adddedUsers = taskProvider.postTaskNotificationUser(taskNotificationUsers).Result;
                int addedCount = adddedUsers.Count;
                int errorCount = taskNotificationUsers.Count - addedCount;
                TaskNotificationDTO taskNotification = new TaskNotificationDTO();
                taskNotification.id_notification = id_notification;
                var result = new { id_notification = id_notification, usersAdded = addedCount, usersError = errorCount,
                    viewHtml = PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskNotificationsUsers.cshtml", new Model.TaskNotificationsUserModel(taskNotification)).RenderToString() };

                return Json(result);
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar la notificación");
        }
        [HttpDelete]
        public ActionResult _DeleteTaskNotificationUser(string id_taskNotification, string user_id)
        {
            if (ModelState.IsValid)
            {
                if (taskProvider.deleteTaskNotificationUser(id_taskNotification, user_id, Request.Cookies["user_id"].Value).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar la notificación");
        }
        [HttpPost]
        public ActionResult _AnswerTaskForm(List<string> answers)
        {
            if (ModelState.IsValid)
            {
                var parameters = Request.Params;
                TaskProvider taskProvider = new TaskProvider();
                //if (taskProvider.postTaskNotification(taskNotification).Result)
                //{
                //    return _TaskNotificationList(taskNotification.task_id);
                //}
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar la notificación");
        }
        [HttpPost]
        public ActionResult _ConfirrmTask(string id_task)
        {
            if (ModelState.IsValid)
            {
                var parameters = Request.Params;
                TaskProvider taskProvider = new TaskProvider();
                TaskResponsableDTO taskResponsableDTO = new TaskResponsableDTO();
                taskResponsableDTO.task_id = id_task;
                taskResponsableDTO.user_id = Request.Cookies["user_id"].Value;
                taskResponsableDTO.isConfirmed = "True";
                taskResponsableDTO.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTaskResponsable(taskResponsableDTO).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar la notificación");
        }
    }
}