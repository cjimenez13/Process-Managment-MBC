using System;
using System.Collections.Generic;
using DataTransferObjects;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace BeyondThemes.BeyondAdmin.Providers
{
    class TemplatesProvider : ProcessManagmentProvider
    {
        public async Task<List<TemplateDTO>> getTemplates()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<TemplateDTO> templates = new List<TemplateDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/templates/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    templates = serializer.Deserialize<List<TemplateDTO>>(result);
                }
                return templates;
            }
        }

        public async Task<TemplateDTO> getTemplate(string id_template)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                TemplateDTO template = new TemplateDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/templates/?id_template=" + id_template).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    template = serializer.Deserialize<TemplateDTO>(result);
                }
                return template;
            }
        }
        //-------------------------------------- Posts --------------------------------------------------

        public async Task<bool> postTemplate(TemplateDTO templateDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(templateDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/templates/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        //-------------------------------------- Puts --------------------------------------------------
        public async Task<bool> putTemplate(TemplateDTO templateDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(templateDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/templates/", contentPost).Result;

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }

        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteTemplate(string id_template, string userLog)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/templates/?id_template=" + id_template + "&userLog=" + userLog ).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
    }
}
