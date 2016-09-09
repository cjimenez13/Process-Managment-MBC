using DataTransferObjects;
using System.Collections.Generic;
using System.Net;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/Roles")]
    public class RolesController : ApiController
    {
        // GET: Roles
        [HttpGet]
        public IEnumerable<RoleDTO> Get()
        {
            List<RoleDTO> roles = RolesData.getRoles();
            return roles;
        }
        
        [HttpPost]
        public RoleDTO Post(RoleDTO pRoleDTO)
        {
            RoleDTO roleDTO = new RoleDTO();
            if ((roleDTO.id_role = RolesData.insertRoll(pRoleDTO)) == null)
            {
                throw new HttpResponseException(HttpStatusCode.NotFound);
            }
            return roleDTO;
        }
        [HttpDelete]
        public IHttpActionResult Delete(int id_role)
        {
            if (!RolesData.deleteRole(id_role.ToString()))
            {
                return BadRequest();
            }
            return Ok();
        }
        [Route("modules")]
        [HttpGet]
        public IEnumerable<ModuleDTO> modules()
        {
            List<ModuleDTO> modules = RolesData.getModules();
            return modules;
        }
        [Route("role/module_permissions")]
        [HttpGet]
        public IEnumerable<PermissionDTO> rolePermissionsbyModule(string id_rol, string id_module)
        {
            List<PermissionDTO> permissions = RolesData.getRolePermissions(id_rol,id_module);
            return permissions;
        }

        [Route("role/permission_elements")]
        [HttpGet]
        public IEnumerable<ElementDTO> permissionElementsbyRole(string id_rolePermission)
        {
            List<ElementDTO> elements = RolesData.getElements(id_rolePermission);
            return elements;
        }

        [Route("role/element")]
        [HttpPut]
        public IHttpActionResult updateRoleElement(ElementDTO pElementDTO)
        {
            if (!RolesData.updateRoleElement(pElementDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [Route("role/permission")]
        [HttpPut]
        public IHttpActionResult updateRoleElement(PermissionDTO pPermissionDTO)
        {
            if (!RolesData.updateRolePermission(pPermissionDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

    }
}