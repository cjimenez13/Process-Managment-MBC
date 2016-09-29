using System.Web.Mvc;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    [Authorize]
    public class ProcessesController : Controller
    {
        // GET: Proccess
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Process()
        {
            return View();
        }
        public ActionResult Tasks()
        {
            return View();
        }
    }
}