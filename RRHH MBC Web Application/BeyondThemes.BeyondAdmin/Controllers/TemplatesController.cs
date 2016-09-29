using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    public class TemplatesController : Controller
    {
        TemplatesProvider templateProvider = new TemplatesProvider();
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
    }
}