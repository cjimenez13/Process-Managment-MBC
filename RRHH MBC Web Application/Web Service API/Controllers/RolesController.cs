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
    }
}