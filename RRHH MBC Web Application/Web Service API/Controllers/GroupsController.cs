﻿using DataTransferObjects;
using System.Collections.Generic;
using System.Net;
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
        [HttpGet]
        public GroupDTO Get(string id_group)
        {
            GroupDTO group = GroupsData.getGroup(id_group);
            return group;
        }

        [HttpPost]
        public IHttpActionResult Post(GroupDTO pGroupDTO)
        {
            if (!GroupsData.insertGroup(pGroupDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        public IHttpActionResult Put(GroupDTO pGroupDTO)
        {
            if (!GroupsData.updateGroup(pGroupDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpDelete]
        public IHttpActionResult Delete(int id_group)
        {
            if (!GroupsData.deleteGroup(id_group.ToString()))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("members")]
        [HttpGet]
        public IEnumerable<UserDTO> getGroupMembers(string group_id)
        {
            List<UserDTO> users = GroupsData.getGroupUsers(group_id);
            return users;
        }

    }
}