using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using Model;
using System.Net;
using System.Net.Mime;
using System.Web.Mvc;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    public class ConfigController : Controller
    {
        RoleProvider roleProvider = new RoleProvider();
        // GET: Config
        public ActionResult Index(RolesListModel model)
        {
            return View(model);
        }

        [HttpGet]
        public ActionResult Role(string id)
        {
            return View();
        }

        [HttpPost]
        public ActionResult _AddRole(AddRoleModel model)
        {
            if (ModelState.IsValid)
            {
                RoleDTO roleDTO = new RoleDTO();
                roleDTO.name = model.name;
                roleDTO.description = model.description;
                RoleDTO newRole = roleProvider.postRole(roleDTO).Result;
                //model.rolesListModel.rolesList = roleProvider.getRoles().Result;
                if (newRole.id_role != null)
                {
                    roleDTO.id_role = newRole.id_role;
                    //return Json(roleDTO);
                    return PartialView("/Views/Config/_Security.cshtml", new Model.RolesListModel());
                }
            }
            Response.StatusCode = (int)HttpStatusCode.BadRequest;
            return Json("The attached file is not supported", MediaTypeNames.Text.Plain);
            //return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpDelete]
        public ActionResult _DeleteRole(string id_role)
        {
            RoleDTO roleDTO = new RoleDTO();
            roleDTO.id_role = id_role;
            if (roleProvider.deleteRole(roleDTO).Result)
            {
                return PartialView("/Views/Config/_Security.cshtml", new Model.RolesListModel());
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
    }
}