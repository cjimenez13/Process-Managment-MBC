using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    public class TemplatesController : Controller
    {
        // GET: Templates
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Template()
        {
            return View();
        }
        public ActionResult Tasks()
        {
            return View();
        }
    }
}