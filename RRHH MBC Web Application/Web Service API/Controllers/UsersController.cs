using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;
using DataTransferObjects;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/Users")]
    public class UsersController : ApiController
    {
        // GET: api/users/provinces
        [Route("provinces")]
        [HttpGet]
        public IEnumerable<ProvinceDTO> provinces()
        {
            List<ProvinceDTO> provinces = UsersData.getProvinces();
            return provinces;
        }

        // GET: api/users/cantones
        [Route("cantones")]
        [HttpGet]
        public IEnumerable<CantonDTO> cantones(int province_id)
        {
            List<CantonDTO> cantones = UsersData.getCantones(province_id);
            return cantones;
        }
        // POST: api/users/registeruser
        [Route("RegisterUser")]
        [HttpPost]
        public IHttpActionResult RegisterUser(UserDTO userDTO)
        {
            if (!UsersData.createUser(userDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpGet]
        public IEnumerable<UserDTO> Get()
        {
            List<UserDTO> users = UsersData.getUsers();
            return users;
        }
        [HttpGet]
        public UserDTO Get(string user)
        {
            UserDTO userDTO = UsersData.getUser(user);
            return userDTO;
        }
        [HttpPut]
        public IHttpActionResult Put(UserDTO userDTO)
        {
            if (!UsersData.updateUser(userDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [Route("Photo")]
        [HttpPut]
        public IHttpActionResult Photo(FileDTO fileDTO)
        {
            if (!UsersData.updatePhoto(fileDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

    }
}