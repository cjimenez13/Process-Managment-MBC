using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    public class ScriptsController : Controller
    {

        // GET: Script
        public ActionResult Index()
        {
            return View("/Views/Scripts/Index.cshtml");
        }
    }
}