using BeyondThemes.BeyondAdmin.Providers;
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
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Process(string id)
        {
            return View(new Model.ProcessModel(id));
        }
        public ActionResult Tasks()
        {
            return View();
        }

        public ActionResult _ProcessList()
        {
            return PartialView("/Views/Processes/_Index/_ProcessList.cshtml", new Model.ProcessListModel());
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
                if (processProvider.postProcess(processDTO).Result)
                {
                    return _ProcessList();
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
    }
}