using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Mvc;
using BeyondThemes.BeyondAdmin.Tools;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    public class TemplatesController : Controller
    {
        TemplatesProvider templateProvider = new TemplatesProvider();
        ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();
        // GET: Templates
        [Authorize]
        [ValidateLogin]
        public ActionResult Index()
        {
            return View();
        }
        [Authorize]
        [ValidateLogin]
        public ActionResult Template(string id)
        {
            Model.TemplateModel model = new Model.TemplateModel(id);
            if (model.templateDTO.id_processManagment != null) 
                return View(new Model.TemplateModel(id));
            else
                return View("/Views/Home/Error404.cshtml");
        }
        [Authorize]
        [ValidateLogin]
        public ActionResult Tasks(string id)
        {
            Model.TasksModel model = new Model.TasksModel(id);
            if (model.stage.id_stage != null)
                return View(new Model.TasksModel(id));
            else
                return View("/Views/Home/Error404.cshtml");
        }
        [Authorize]
        public ActionResult _TemplatesList()
        {
            return PartialView("/Views/Templates/_Index/_TemplatesList.cshtml", new Model.TemplatesListModel());
        }
        [Authorize]
        public ActionResult _TemplateParticipantsList(string id_process)
        {
            return PartialView("/Views/Templates/_Template/_Participants/_TemplateParticipantsList.cshtml", new Model.ParticipantsModel(id_process));
        }
        [Authorize]
        public ActionResult _StagesList(string id_process)
        {
            return PartialView("/Views/Templates/_Template/_Stages/_StagesList.cshtml", new Model.StagesListModel(id_process));
        }
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult _AddTemplate(Model.AddTemplateModel model)
        {
            if (ModelState.IsValid)
            {
                TemplateDTO templateDTO = new TemplateDTO();
                templateDTO.name = model.name;
                templateDTO.categorie_id = model.categorie_id;
                templateDTO.userLog = Request.Cookies["user_id"].Value;
                if (templateProvider.postTemplate(templateDTO).Result)
                {
                    return _TemplatesList();
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        [ValidateAntiForgeryToken]
        public ActionResult _EditTemplate(string name, string template_id)
        {
            if (ModelState.IsValid)
            {
                TemplateDTO templateDTO = new TemplateDTO();
                templateDTO.name = name;
                templateDTO.id_processManagment = template_id;
                templateDTO.userLog = Request.Cookies["user_id"].Value;
                if (templateProvider.putTemplate(templateDTO).Result)
                {
                    return Content(name);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpDelete]
        public ActionResult _DeleteTemplate(string id_template)
        {
            TemplateDTO templateDTO = new TemplateDTO();
            if (templateProvider.deleteTemplate(id_template, Request.Cookies["user_id"].Value).Result)
            {
                return RedirectToAction("Index", "Templates");
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddProcessUser(string process_id, List<string> selected_userParticipants_id)
        {
            if (ModelState.IsValid)
            {
                List<ParticipantDTO> participants = new List<ParticipantDTO>();
                foreach (var participant_id in selected_userParticipants_id)
                {
                    ParticipantDTO participantDTO = new ParticipantDTO();
                    participantDTO.processManagment_id = process_id;
                    participantDTO.user_id = participant_id;
                    participantDTO.userLog = Request.Cookies["user_id"].Value;
                    participants.Add(participantDTO);
                }
                List<ParticipantDTO> addedParticipants = processManagmentProvider.postParticipants(participants).Result;
                int addedCount = addedParticipants.Count;
                int errorCount = participants.Count - addedCount;
                var result = new { usersAdded = addedCount, usersError = errorCount, viewHtml = PartialView("/Views/Templates/_Template/_Participants/_TemplateParticipantsList.cshtml", new Model.ParticipantsModel(process_id)).RenderToString() };
                return Json(result);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddProcessGroup(string process_id, List<string> selected_groups_id)
        {
            if (ModelState.IsValid)
            {
                List<ParticipantDTO> groups = new List<ParticipantDTO>();
                foreach (var group_id in selected_groups_id)
                {
                    ParticipantDTO groupParticipantDTO = new ParticipantDTO();
                    groupParticipantDTO.processManagment_id = process_id;
                    groupParticipantDTO.user_id = group_id;
                    groupParticipantDTO.userLog = Request.Cookies["user_id"].Value;
                    groups.Add(groupParticipantDTO);
                }
                List<ParticipantDTO> addedParticipants = processManagmentProvider.postGroups(groups).Result;
                var result = new { usersAdded = selected_groups_id.Count, viewHtml = PartialView("/Views/Templates/_Template/_Participants/_TemplateParticipantsList.cshtml", new Model.ParticipantsModel(process_id)).RenderToString() };
                return Json(result);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpDelete]
        public ActionResult _DeleteParticipant(string user_id, string process_id)
        {
            if (templateProvider.deleteParticipant(user_id, process_id, Request.Cookies["user_id"].Value).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddStage(string name, string id_process, string maxStagePosition)
        {
            if (ModelState.IsValid)
            {
                StageDTO stageDTO = new StageDTO();
                stageDTO.processManagment_id = id_process;
                stageDTO.name = name;
                stageDTO.stagePosition = maxStagePosition;
                stageDTO.userLog = Request.Cookies["user_id"].Value;
                if (processManagmentProvider.postStage(stageDTO).Result){
                    return _StagesList(id_process);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        public ActionResult _EditStage(string name, string id_stage, string stagePosition)
        {
            if (ModelState.IsValid)
            {
                StageDTO stageDTO = new StageDTO();
                stageDTO.id_stage = id_stage;
                stageDTO.name = name;
                stageDTO.stagePosition = stagePosition;
                stageDTO.userLog = Request.Cookies["user_id"].Value;
                if (processManagmentProvider.putStage(stageDTO).Result)
                {
                    var result = new { name = name, id_stage = id_stage };
                    return Json(result);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpDelete]
        public ActionResult _DeleteStage(string id_stage)
        {
            if (ModelState.IsValid)
            {
                if (processManagmentProvider.deleteStage(id_stage, Request.Cookies["user_id"].Value).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }


    }
}