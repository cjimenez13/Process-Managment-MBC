using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/categories")]
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
    }
}