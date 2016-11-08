using DataTransferObjects;
using System.Collections.Generic;
using System.Web.Http;
using Web_Service_API.DataAccess;

namespace Web_Service_API.Controllers
{
    [RoutePrefix("api/templates")]
    [Authorize]
    public class TemplatesController : ApiController
    {
        [HttpGet]
        public IEnumerable<TemplateDTO> Get()
        {
            List<TemplateDTO> templates = TemplatesData.getTemplates();
            return templates;
        }
        [HttpGet]
        public TemplateDTO Get(string id_template)
        {
            TemplateDTO template = TemplatesData.getTemplate(id_template);
            return template;
        }
        [HttpGet]
        public List<TemplateDTO> GetTemplatesByCategorie(string categorie_id)
        {
            List<TemplateDTO> templates = TemplatesData.getTemplatesbyCategorie(categorie_id);
            return templates;
        }
        [HttpPost]
        public IHttpActionResult Post(TemplateDTO templateDTO)
        {
            if (!TemplatesData.insertTemplate(templateDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpPut]
        public IHttpActionResult Put(TemplateDTO pTemplateDTO)
        {
            if (!TemplatesData.updateTemplate(pTemplateDTO))
            {
                return BadRequest();
            }
            return Ok();
        }

        [HttpDelete]
        public IHttpActionResult Delete(string id_template, string userLog)
        {
            if (!TemplatesData.deleteTemplate(id_template, userLog))
            {
                return BadRequest();
            }
            return Ok();
        }
    }
}
