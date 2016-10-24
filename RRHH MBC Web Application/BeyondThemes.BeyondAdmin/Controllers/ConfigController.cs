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
        [Authorize]
        [ValidateLogin]
        [HttpGet]
        public ActionResult Index(RolesListModel model)
        {
            return View(model);
        }

        [HttpGet]
        [Authorize]
        [ValidateLogin]
        public ActionResult Role(string id)
        {
            RoleModel model = new RoleModel(id);
            if (model.role.id_role != null)
                return View(new Model.RoleModel(id));
            else
                return View("/Views/Home/Error404.cshtml");
        }


        [HttpGet]
        [Authorize]
        public ActionResult _RoleModules(string id_role)
        {
            return PartialView("/Views/Config/_Role/_RoleModules.cshtml", new RoleModel(id_role));
        }
        [HttpGet]
        [Authorize]
        public ActionResult _PermissionElements(string id_rolePermission)
        {
            return PartialView("/Views/Config/_Role/_PermissionElements.cshtml", new ElementsModel(id_rolePermission));
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
                    return PartialView("/Views/Config/_Index/_Security.cshtml", new Model.RolesListModel());
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
                return PartialView("/Views/Config/Index/_Security.cshtml", new Model.RolesListModel());
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpPut]
        public ActionResult _UpdateRolePermission(string id_role_permission, string isEnabled)
        {
            PermissionDTO permissionDTO = new PermissionDTO();
            permissionDTO.id_role_permission = id_role_permission;
            permissionDTO.isEnabled = isEnabled;
            if (roleProvider.putRolePermission(permissionDTO).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpPut]
        public ActionResult _UpdateRoleElement(string role_permission_id, string id_element, string isEnabled)
        {
            ElementDTO elementDTO = new ElementDTO();
            elementDTO.role_permission_id = role_permission_id;
            elementDTO.id_element = id_element;
            elementDTO.isEnabled = isEnabled;
            if (roleProvider.putRoleElement(elementDTO).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
    }
}