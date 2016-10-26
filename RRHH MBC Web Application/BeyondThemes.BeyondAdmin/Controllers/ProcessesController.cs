﻿using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Mvc;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    [Authorize]
    public class ProcessesController : Controller
    {
        private ProcessProvider processProvider = new ProcessProvider();
        private TemplatesProvider templatesProvider = new TemplatesProvider();

        // GET: Proccess
        [ValidateLogin]
        public ActionResult Index()
        {
            return View();
        }
        [ValidateLogin]
        public ActionResult Process(string id)
        {
            Model.ProcessModel model = new Model.ProcessModel(id);

            if (model.processDTO.id_processManagment != null)
            {
                bool isProcess = false;
                foreach (var participant in model.participantsModel.participants)
                {
                    if (participant.user_id == Request.Cookies["user_id"].Value)
                    {
                        isProcess = true;
                    }
                }
                if (isProcess)
                {
                    return View(new Model.ProcessModel(id));
                }
            }
            return View("/Views/Home/Error404.cshtml");
        }
        [ValidateLogin]
        public ActionResult Tasks()
        {
            return View();
        }

        public ActionResult _ProcessList()
        {
            Model.ProcessListModel model = new Model.ProcessListModel();
            model.actualUser = HttpContext.Request.Cookies["user_id"].Value;
            return PartialView("/Views/Processes/_Index/_ProcessList.cshtml", model);
        }
        [HttpGet]
        public ActionResult getTemplates(string categorie_id)
        {
            List<TemplateDTO> templates;
            templates = templatesProvider.getTemplatesByCategorie(categorie_id).Result;
            return Json(templates, JsonRequestBehavior.AllowGet);
        }
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult _AddProcess(Model.AddProcessModel model)
        {
            if (ModelState.IsValid)
            {
                ProcessDTO processDTO = new ProcessDTO();
                processDTO.name = model.name;
                processDTO.categorie_id = model.categorie_id;
                processDTO.template_id = model.template_id;
                processDTO.userLog = Request.Cookies["user_id"].Value;
                if (processProvider.postProcess(processDTO).Result != "-1")
                {
                    return _ProcessList();
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult _BifurcateProcess(Model.AddProcessModel model)
        {
            if (ModelState.IsValid)
            {
                ProcessDTO processDTO = new ProcessDTO();
                processDTO.name = model.name;
                processDTO.categorie_id = model.categorie_id;
                processDTO.template_id = model.template_id;
                processDTO.userLog = Request.Cookies["user_id"].Value;
                string id_process;
                if ((id_process = processProvider.postProcess(processDTO).Result) != "-1")
                {
                    BifurcateProcessDTO bifurcateProcessDTO = new BifurcateProcessDTO();
                    bifurcateProcessDTO.previousProcess = model.bifurcateProcess_id;
                    bifurcateProcessDTO.nextProcess = id_process;
                    bifurcateProcessDTO.userLog = Request.Cookies["user_id"].Value;
                    if (processProvider.bifurcateProcess(bifurcateProcessDTO).Result)
                    {
                        return new HttpStatusCodeResult(200);
                    }
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [ValidateAntiForgeryToken]
        [HttpPut]
        public ActionResult _EditProcess(string name, string id_process)
        {
            if (ModelState.IsValid)
            {
                ProcessDTO processDTO = new ProcessDTO();
                processDTO.name = name;
                processDTO.id_processManagment = id_process;
                processDTO.userLog = Request.Cookies["user_id"].Value;
                if (processProvider.putProcess(processDTO).Result)
                {
                    return Json(processDTO);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [ValidateAntiForgeryToken]
        [HttpDelete]
        public ActionResult _DeleteProcess(string id_process)
        {
            if (ModelState.IsValid)
            {
                if (processProvider.deleteProcess(id_process, Request.Cookies["user_id"].Value).Result)
                {
                    return new HttpStatusCodeResult(404, "Can't find that");
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
    }
}