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
        [HttpGet]
        public UserDTO GetbyId(string user_id)
        {
            UserDTO userDTO = UsersData.getUserbyID(user_id);
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

        [Route("Files")]
        [HttpGet]
        public List<FileDTO> Files(string user)
        {
            return UsersData.getUserFiles(user);
        }

        [Route("Files")]
        [HttpDelete]
        public IHttpActionResult deleteFile(string id_file)
        {
            if (!UsersData.deleteFile(id_file))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("File")]
        [HttpPost]
        public IHttpActionResult File(FileDTO fileDTO)
        {
            if (!UsersData.postFile(fileDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [Route("roles")]
        [HttpGet]
        public List<RoleDTO> userRoles(string user_id)
        {
            return UsersData.getUserRoles(user_id);
        }

        [Route("role")]
        [HttpPost]
        public IHttpActionResult insertUserRole(RoleDTO pRoleDTO)
        {
            if (!UsersData.insertUserRoll(pRoleDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("role")]
        [HttpDelete]
        public IHttpActionResult insertUserRole(string role_id, string user_id)
        {
            if (!UsersData.deleteUserRole(role_id, user_id))
            {
                return BadRequest();
            }
            return Ok();
        }
        [Route("attributes")]
        [HttpGet]
        public List<PersonalAttributeDTOmin> userAttributes(string user_id, string categorie_id)
        {
            return UsersData.getUserAttributesbyCatgorie(user_id, categorie_id);
        }
        [Route("attributes")]
        [HttpPut]
        public IHttpActionResult updateUserAttribute(PersonalAttributeDTOmin personalAttributeDTO)
        {
            if (!UsersData.updateUserAttribute(personalAttributeDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [Route("attributes/categories")]
        [HttpGet]
        public List<CategorieDTO> userCategories(string user_id)
        {
            return UsersData.getUserCategories(user_id);
        }

    }
}