using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Web.Mvc;
using DataTransferObjects;
using BeyondThemes.BeyondAdmin.Tools;
using System.Web;
using System.IO;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    public class ScriptsController : Controller
    {
        ScriptsProvider scriptProvider = new ScriptsProvider();
        // GET: Script
        [Authorize]
        [ValidateLogin]
        public ActionResult Index()
        {
            return View("/Views/Scripts/Index.cshtml", new Model.ScriptsModel());
        }

        [HttpPost]
        public ActionResult _AddScript(Model.AddScriptModel model )
        {
            if (ModelState.IsValid)
            {
                ScriptsLogDTO script = new ScriptsLogDTO();
                if (model.scriptType == "file")
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
                        script.script = System.Text.Encoding.UTF8.GetString(bytes);
                    }
                }
                else
                {
                    script.script = model.scriptText;
                }
                script.userLog = Request.Cookies["user_id"].Value;
                string result;
                if ((result = scriptProvider.postScript(script).Result) != "-1")
                {
                    if (script.script.ToLower().Contains("select"))
                        return Json(new { type = "table", result = PartialView("/Views/Scripts/_ScriptResult.cshtml", new Model.ScriptResultTable(result)).RenderToString() });
                    else
                        return Json(new { type = "affectedRows", result = result });
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
    }

}