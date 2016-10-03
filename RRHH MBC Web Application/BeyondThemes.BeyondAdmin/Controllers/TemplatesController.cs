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
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Template(string id)
        {
            return View(new Model.TemplateModel(id));
        }
        public ActionResult Tasks()
        {
            return View();
        }
        public ActionResult _TemplatesList()
        {
            return PartialView("/Views/Templates/_TemplatesList.cshtml", new Model.TemplatesListModel());
        }
        public ActionResult _TemplateParticipantsList(string id_process)
        {
            return PartialView("/Views/Templates/_TemplateParticipantsList.cshtml", new Model.ParticipantsModel(id_process));
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

        [HttpPost]
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
                var result = new { usersAdded = addedCount, usersError = errorCount, viewHtml = PartialView("/Views/Templates/_TemplateParticipantsList.cshtml", new Model.ParticipantsModel(process_id)).RenderToString() };
                return Json(result);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPost]
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
                var result = new { usersAdded = addedParticipants, viewHtml = PartialView("/Views/Templates/_TemplateParticipantsList.cshtml", new Model.ParticipantsModel(process_id)).RenderToString() };
                return Json(result);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
    }
}