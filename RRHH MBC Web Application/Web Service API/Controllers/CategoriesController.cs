using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/categories")]
    [Authorize]
    public class CategoriesController : ApiController
    {
        // GET: Categories
        [HttpGet]
        public IEnumerable<CategorieDTO> Get()
        {
            List<CategorieDTO> categories = CategoriesData.getCategories();
            return categories;
        }
        [HttpGet]
        public CategorieDTO Get(string id_categorie)
        {
            CategorieDTO categorie = CategoriesData.getCategorie(id_categorie);
            return categorie;
        }

        [HttpPost]
        public IHttpActionResult Post(CategorieDTO pCategorieDTO)
        {
            if (!CategoriesData.insertCategorie(pCategorieDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpPut]
        public IHttpActionResult Put(CategorieDTO pCategorieDTO)
        {
            if (!CategoriesData.updateCategorie(pCategorieDTO))
            {
                return BadRequest();
            }
            return Ok();
        }
        [HttpDelete]
        public IHttpActionResult Delete(string id_categorie)
        {
            if (!CategoriesData.deleteCategorie(id_categorie))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("generalAttr")]
        [HttpGet]
        public IEnumerable<GeneralAttributeDTO> getGeneralAttributes(string categorie_id)
        {
            List<GeneralAttributeDTO> attributes = CategoriesData.getGeneralAttributes(categorie_id);
            return attributes;
        }

        [Route("generalAttr")]
        [HttpGet]
        public GeneralAttributeDTO getGeneralAttribute(string id_attribute)
        {
            GeneralAttributeDTO attribute = CategoriesData.getGeneralAttribute(id_attribute);
            return attribute;
        }

        [Route("generalAttr")]
        [HttpPost]
        public IHttpActionResult postGeneralAttribute(GeneralAttributeDTO pGeneralAttributeDTO)
        {
            if (!CategoriesData.insertGeneralAttribute(pGeneralAttributeDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("generalAttr")]
        [HttpPut]
        public IHttpActionResult putGeneralAtrribute(GeneralAttributeDTO pGeneralAttributeDTO)
        {
            if (!CategoriesData.updateGeneralAttribute(pGeneralAttributeDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("generalAttr")]
        [HttpDelete]
        public IHttpActionResult DeleteGeneralAttribute(string id_attribute, string user)
        {
            if (!CategoriesData.deleteGeneralAttribute(id_attribute,user))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("personalAttr")]
        [HttpGet]
        public IEnumerable<PersonalAttributeDTO> getPersonalAttributes(string categorie_id)
        {
            List<PersonalAttributeDTO> attributes = CategoriesData.getPersonalAttributes(categorie_id);
            return attributes;
        }

        [Route("personalAttr")]
        [HttpGet]
        public PersonalAttributeDTO getPersonalAttribute(string id_attribute)
        {
            PersonalAttributeDTO attribute = CategoriesData.getPersonalAttribute(id_attribute);
            return attribute;
        }

        [Route("personalAttr")]
        [HttpPost]
        public IHttpActionResult postPersonalAttribute(PersonalAttributeDTO pPersonaAttributeDTO)
        {
            if (!CategoriesData.insertPersonalAttribute(pPersonaAttributeDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("personalAttr")]
        [HttpPut]
        public IHttpActionResult putPersonalAtrribute(PersonalAttributeDTO pPersonaAttributeDTO)
        {
            if (!CategoriesData.updatePersonalAttribute(pPersonaAttributeDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("personalAttr")]
        [HttpDelete]
        public IHttpActionResult DeletePersonalAttribute(string id_attribute, string userLog)
        {
            if (!CategoriesData.deletePersonalAttribute(id_attribute, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("attrTypes")]
        [HttpGet]
        public IEnumerable<AttributeTypeDTO> getAttributeTypes()
        {
            List<AttributeTypeDTO> type = CategoriesData.getAttributeTypes();
            return type;
        }
        [Route("attrTypes")]
        [HttpGet]
        public AttributeTypeDTO getAttributeTypes(string id_type)
        {
            AttributeTypeDTO type = CategoriesData.getAttributeTypes(id_type);
            return type;
        }

        [Route("attributesList")]
        [HttpGet]
        public IEnumerable<AttributeListDTO> getAttributesList(string id_attribute)
        {
            List<AttributeListDTO> attributes = CategoriesData.getAttributesList(id_attribute);
            return attributes;
        }

        [Route("attributesList")]
        [HttpGet]
        public AttributeListDTO getAttributeList(string id_attributeValue)
        {
            AttributeListDTO attribute = CategoriesData.getAttributeList(id_attributeValue);
            return attribute;
        }

        [Route("attributesList")]
        [HttpPost]
        public IHttpActionResult postAttributeList(AttributeListDTO pAttributeList)
        {
            if (!CategoriesData.insertAttributeList(pAttributeList))
            {
                return BadRequest();
            }
            return Ok();
        }
        [Route("attributesList")]
        [HttpPut]
        public IHttpActionResult putAtrributeList(AttributeListDTO pAttributeList)
        {
            if (!CategoriesData.updateAttributeList(pAttributeList))
            {
                return BadRequest();
            }
            return Ok();
        }

        [Route("attributesList")]
        [HttpDelete]
        public IHttpActionResult DeleteAttributeList(string id_attributeValue, string user)
        {
            if (!CategoriesData.deleteAttributeList(id_attributeValue, user))
            {
                return BadRequest();
            }
            return Ok();
        }
    }
}