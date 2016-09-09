using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/Groups")]
    public class GroupsController : ApiController
    {
        // GET: Groups
        [HttpGet]
        public IEnumerable<GroupDTO> Get()
        {
            List<GroupDTO> groups = GroupsData.getGroups();
            return groups;
        }
    }
}