using BeyondThemes.BeyondAdmin.Providers;
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
using System.Text;

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
        public ActionResult _TaskList(string id_stage)
        {
            return PartialView("/Views/Tasks/_Tasks/_TasksList.cshtml", new Model.TasksModel(id_stage));
        }
        public ActionResult _TaskDetails(string id_task)
        {
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails.cshtml", new Model.TaskDetailsModel(id_task));
        }
        public ActionResult _AddResponsables(string id_task)
        {
            TaskDTO task = taskProvider.getTask(id_task).Result;
            //task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskResponsables.cshtml", new Model.TaskResponsablesModel(task));
        }
        public ActionResult _AddForm(string id_task)
        {
            TaskDTO task = taskProvider.getTask(id_task).Result;
            //task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskForm.cshtml", new Model.FormQuestionsModel(task));
       }
        public ActionResult _AddAditionals(string id_task)
        {
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskAdditionals.cshtml", new TaskDetailsModel(id_task));
        }
        public ActionResult _AddTaskChanges(string id_task)
        {
            TaskDTO task = taskProvider.getTask(id_task).Result;
            //task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskDataChanges.cshtml", new Model.TaskChangesModel(task));
        }
        public ActionResult _TaskQuestions(string id_task)
        {
            TaskDTO task = taskProvider.getTask(id_task).Result;
            //task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskQuestions.cshtml", new Model.FormQuestionsModel(task));
        }
        public ActionResult _TaskDataChangesList(string id_task)
        {
            TaskDTO task = taskProvider.getTask(id_task).Result;
            //task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskDataChangesList.cshtml", new Model.TaskChangesModel(task));
        }
        public ActionResult _TaskFilesList(string id_task)
        {
            TaskDTO task = taskProvider.getTask(id_task).Result;
            //task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskFilesList.cshtml", new Model.TaskFilesModel(task));
        }
        public ActionResult _TaskNotificationList(string id_task)
        {
            TaskDTO task = taskProvider.getTask(id_task).Result;
            //task.id_task = id_task;
            return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskNotificationsList.cshtml", new Model.TaskNotificationsModel(task));
        }
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
                List<TaskDTO> tasks = taskProvider.getTasks(model.id_stage).Result; 
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.name = model.name;
                taskDTO.description = model.description;
                taskDTO.stage_id = model.id_stage;
                taskDTO.type_id = model.selected_taskType;
                if (tasks.Count == 0)
                    taskDTO.taskPosition = "0";
                else
                    taskDTO.taskPosition = (Int32.Parse(tasks[tasks.Count - 1].taskPosition) + 1).ToString();
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
                        StageDTO stageDTO = new ProcessManagmentProvider().getStage(taskDTO.stage_id).Result;
                        if (taskProvider.putRefreshTaskTimes(stageDTO.processManagment_id).Result)
                        {
                            var result = new { id_task = id_task, viewHtml = PartialView("/Views/Tasks/_Tasks/_TasksList.cshtml", new Model.TasksModel(taskDTO.stage_id)).RenderToString() };
                            return Json(result);
                        }
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
                    taskDTO.finishDate = model.timeDatePicker + " " + model.timeHour;

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
                    taskDTO.finishDate = model.finishDateE + " " + model.finishTimeE;
                }
                taskDTO.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTask(taskDTO).Result)
                {
                    TaskDTO editedTask = taskProvider.getTask(taskDTO.id_task).Result;
                    StageDTO stage = new ProcessManagmentProvider().getStage(editedTask.stage_id).Result;
                    if (taskProvider.putRefreshTaskTimes(stage.processManagment_id).Result)
                    {
                        return PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskInfo.cshtml", new Model.TaskDetailsModel(taskDTO.id_task));
                    }
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        public ActionResult _EditTaskPosition(string id_task, string taskPosition)
        {
            if (ModelState.IsValid)
            {
                TaskDTO taskDTO = new TaskDTO();
                taskDTO.id_task = id_task;
                taskDTO.taskPosition = taskPosition;
                taskDTO.userLog = Request.Cookies["user_id"].Value;
                if (taskProvider.putTask(taskDTO).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpPut]
        public ActionResult _RefreshTaskTimes(string id_task)
        {
            if (ModelState.IsValid)
            {
                TaskDTO task = taskProvider.getTask(id_task).Result;
                StageDTO stage = new ProcessManagmentProvider().getStage(task.stage_id).Result;
                if (taskProvider.putRefreshTaskTimes(stage.processManagment_id).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpDelete]
        public ActionResult _DeleteTask(string id_task)
        {
            TaskDTO taskDTO = taskProvider.getTask(id_task).Result;
            StageDTO stage = new ProcessManagmentProvider().getStage(taskDTO.stage_id).Result;
            if (taskProvider.deleteTask(id_task, Request.Cookies["user_id"].Value).Result)
            {
                if (taskProvider.putRefreshTaskTimes(stage.processManagment_id).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
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
                TaskDTO taskDTO = taskProvider.getTask(id_task).Result;
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
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddFormUser(string taskForm_id, List<string> selected_userForm_id)
        {
            if (ModelState.IsValid)
            {
                List<TaskFormUserDTO> actualUsers = taskProvider.getFormUsers(taskForm_id).Result;
                if (actualUsers.Count < 1)
                {
                    List<TaskFormUserDTO> users = new List<TaskFormUserDTO>();
                    if (selected_userForm_id.Count > 1)
                    {
                        return new HttpStatusCodeResult(404, "Solamente se permite agregar un usuario");
                    }
                    else
                    {
                        foreach (var responsable_id in selected_userForm_id)
                        {
                            TaskFormUserDTO formUser = new TaskFormUserDTO();
                            formUser.user_id = responsable_id;
                            formUser.taskForm_id = taskForm_id;
                            formUser.userLog = Request.Cookies["user_id"].Value;
                            users.Add(formUser);
                        }
                        List<TaskFormUserDTO> addedUsers = taskProvider.postFormUsers(users).Result;
                        int addedCount = addedUsers.Count;
                        int errorCount = users.Count - addedCount;
                        TaskFormDTO taskForm = taskProvider.getTaskForm(taskForm_id).Result;
                        TaskDTO taskDTO = taskProvider.getTask(taskForm.id_task).Result;
                        var result = new { usersAdded = addedCount, usersError = errorCount, viewHtml = PartialView("/Views/Tasks/_Tasks/_TaskDetails/_TaskFormUsersList.cshtml", new Model.AddFormUsersModel(taskDTO, taskForm)).RenderToString() };
                        return Json(result);
                    }
                }
                else
                {
                    return new HttpStatusCodeResult(404, "Solamente se permite agregar un usuario");
                }
            }
            return new HttpStatusCodeResult(404, "Error, no se agregó ningun usuario");
        }
        [HttpDelete]
        public ActionResult _DeleteFormUser(string taskForm_id, string user_id)
        {
            TaskFormUserDTO formUser = new TaskFormUserDTO();
            formUser.taskForm_id = taskForm_id;
            formUser.user_id = user_id;
            formUser.userLog = Request.Cookies["user_id"].Value;
            if (taskProvider.deleteFormUser(formUser).Result)
            {
                return new HttpStatusCodeResult(200);
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
        [HttpPut]
        [ValidateAntiForgeryToken]
        public ActionResult _EditTaskNotification(Model.EditTaskNoficationModel pModel)
        {
            if (ModelState.IsValid)
            {
                TaskProvider taskProvider = new TaskProvider();
                TaskNotificationDTO taskNotification = new TaskNotificationDTO();
                taskNotification.id_notification = pModel.id_notification;
                taskNotification.message = pModel.message;
                taskNotification.userLog = Request.Cookies["user_id"].Value;
                taskNotification.isStarting = "False";
                taskNotification.isTelegram = pModel.isTelegram == "on" ? "True" : "False";
                taskNotification.isIntern = pModel.isIntern == "on" ? "True" : "False";
                taskNotification.isEmail = pModel.isEmail == "on" ? "True" : "False";
                taskNotification.task_id = pModel.id_task;
                if (taskProvider.putTaskNotification(taskNotification).Result)
                {
                    if(taskNotification.isTelegram == "True")
                    {
                        
                    }
                    if (taskNotification.isIntern == "True")
                    {

                    }
                    if (taskNotification.isEmail == "True")
                    {

                    }
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
        public ActionResult _AnswerTaskForm(List<string> answers, string id_task)
        {
            if (ModelState.IsValid)
            {
                var parameters = Request.Params;
                TaskProvider taskProvider = new TaskProvider();
                TaskFormDTO taskForm = taskProvider.getTaskFormbyTask(id_task).Result;
                List<TaskQuestionDTO> taskQuestions = taskProvider.getFormQuestions(taskForm.id_taskForm).Result;
                bool isFormAnswered = true;
                int iQuestion = 0;
                foreach(var question in taskQuestions)
                {
                    TaskQuestionAnswerDTO questionAnswer = new TaskQuestionAnswerDTO();
                    questionAnswer.taskQuestion_id = question.id_taskQuestion;
                    questionAnswer.user_id = Request.Cookies["user_id"].Value;
                    questionAnswer.userLog = Request.Cookies["user_id"].Value;
                    if (questionAnswer.questionType_id != "5") //string answer
                    {
                        questionAnswer.responseData = Encoding.UTF8.GetBytes(answers[iQuestion]);
                    }
                    if (questionAnswer.questionType_id != "4") //string answer
                    {
                        questionAnswer.responseData = Encoding.UTF8.GetBytes(answers[iQuestion]);
                    }
                    if (taskProvider.postQuestionAnswer(questionAnswer).Result)
                    {
                        isFormAnswered = false;
                    }
                    iQuestion++;
                }
                if (isFormAnswered)
                {
                    return new HttpStatusCodeResult(200);
                }
                
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
                    List<TaskResponsableDTO> taskResponsables = taskProvider.getTaskResponsables(id_task).Result;
                    bool isTaskCompleted = true;
                    foreach(var user in taskResponsables)
                    {
                        if(user.isConfirmed == "False")
                        {
                            isTaskCompleted = false;
                        }
                    }
                    if (isTaskCompleted)
                    {
                        completeTask(id_task);
                    }
                    return Content(isTaskCompleted ? "True" : id_task);
                }
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar la notificación");
        }
        private void completeTask(string id_task)
        {
            // update completed task
            TaskDTO completedTask = new TaskDTO();
            TaskDTO completedTaskTemporal = taskProvider.getTask(id_task).Result;
            completedTask.id_task = id_task;
            completedTask.taskState_id = "2";
            completedTask.completedDate = DateTime.Now.ToString();
            completedTask.taskPosition = completedTaskTemporal.taskPosition;
            completedTask.stage_id = completedTaskTemporal.stage_id;
            completedTask.userLog = Request.Cookies["user_id"].Value;
            bool isSuccess = taskProvider.putTask(completedTask).Result;
            ProcessDTO actualProcess = new ProcessProvider().getProcess(new ProcessProvider().getStage(completedTask.stage_id).Result.processManagment_id).Result;
            //update next task
            TaskDTO nextTask = new TaskDTO();
            List<TaskDTO> tasks = taskProvider.getTasks(completedTaskTemporal.stage_id).Result;
            foreach (var task in tasks)
            {
                if (Int32.Parse(task.taskPosition) == (Int32.Parse(completedTask.taskPosition)) + 1)
                {
                    nextTask.id_task = task.id_task;
                    break;
                }
            }
            //update stage if is final task
            if (nextTask.id_task == null)
            {
                // completes actual stage
                ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();
                StageDTO actualStage = new StageDTO();
                actualStage.id_stage = completedTask.stage_id;
                actualStage.isCompleted = "True";
                actualStage.completedDate = DateTime.Now.ToString();
                actualStage.userLog = Request.Cookies["user_id"].Value;
                actualStage.processManagment_id = processManagmentProvider.getStage(actualStage.id_stage).Result.processManagment_id;
                bool isStageUpdated = processManagmentProvider.putStage(actualStage).Result;
                // change state of first task 
                List<StageDTO> stages = processManagmentProvider.getStages(actualStage.processManagment_id).Result;
                foreach (var stage in stages)
                {
                    if (stage.isCompleted == "False")
                    {
                        List<TaskDTO> stageTasks = taskProvider.getTasks(stage.id_stage).Result;
                        if (stageTasks.Count >= 1)
                        {
                            TaskDTO firstTask = new TaskDTO();
                            firstTask.taskState_id = "1";
                            firstTask.id_task = stageTasks[0].id_task;
                            firstTask.userLog = Request.Cookies["user_id"].Value;
                            bool isFirstTaskSuccess = taskProvider.putTask(firstTask).Result;
                            break;
                        }
                        else
                        {
                            StageDTO emtpyStage = new StageDTO();
                            emtpyStage.id_stage = stage.id_stage;
                            emtpyStage.isCompleted = "True";
                            emtpyStage.completedDate = DateTime.Now.ToString();
                            emtpyStage.userLog = Request.Cookies["user_id"].Value;
                            bool isEmptyStageUpdated = processManagmentProvider.putStage(actualStage).Result;
                        }

                    }
                }
            }
            //update next task if is not final task
            else
            {
                nextTask.userLog = Request.Cookies["user_id"].Value;
                List<TaskResponsableDTO> nextResponsables = taskProvider.getTaskResponsables(nextTask.id_task).Result;
                if (nextResponsables.Count == 0)
                {
                    completeTask(nextTask.id_task);
                }
                else
                {
                    nextTask.taskState_id = "1";
                    bool isNextSuccess = taskProvider.putTask(nextTask).Result;
                }
            }
            //send notifications
            List<TaskNotificationDTO> notifications = taskProvider.getTaskNotifications(id_task).Result;
            foreach (var notification in notifications)
            {
                TaskNotificationTypeDTO taskNotificationType = new TaskNotificationTypeDTO();
                taskNotificationType.notification_id = notification.id_notification;
                taskNotificationType.userLog = Request.Cookies["user_id"].Value;
                taskNotificationType.isSended = "True";
                List<TaskNotificationUserDTO> notificationUsers = taskProvider.getTaskNotificationUsers(notification.id_notification).Result;
                string msgHeader = "Gestión #" + actualProcess.id_processManagment + " " + actualProcess.name + ", Tarea " + completedTaskTemporal.name;
                //email
                if (notification.isEmail == "True")
                {
                    taskNotificationType.type_id = "1";
                    foreach (var user in notificationUsers)
                    {
                        if (!String.IsNullOrEmpty(user.email))
                            Tools.EmailService.sendEmail(user.email, msgHeader, notification.message);
                    }
                }
                //Telegram 
                if (notification.isTelegram == "True")
                {
                    taskNotificationType.type_id = "2";
                    foreach (var user in notificationUsers)
                    {
                        if (!String.IsNullOrEmpty(user.telegram_id))
                        {
                            TelegramService.sendMessage(user.telegram_id, msgHeader + "\nMensaje:" + notification.message);
                        }
                    }
                }
                if (notification.isIntern == "True")
                {
                    taskNotificationType.type_id = "0";
                }
                bool isTypeUpdated = taskProvider.putTaskNotificationType(taskNotificationType).Result;
            }
        }
    }

}