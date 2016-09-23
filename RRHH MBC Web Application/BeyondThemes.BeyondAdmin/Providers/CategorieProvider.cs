using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Web.Script.Serialization;

namespace BeyondThemes.BeyondAdmin.Providers
{
    class CategorieProvider
    {
        private string _BaseAddress = WebConfigurationManager.AppSettings["WebApi"];
        public async Task<List<CategorieDTO>> getCategories()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<CategorieDTO> categories = new List<CategorieDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    categories = serializer.Deserialize<List<CategorieDTO>>(result);
                }
                return categories;
            }
        }
        public async Task<CategorieDTO> getCategorie(string id_categorie)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                CategorieDTO categorie = new CategorieDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/?id_categorie=" + id_categorie).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    categorie = serializer.Deserialize<CategorieDTO>(result);
                }
                return categorie;
            }
        }

        public async Task<List<AttributeTypeDTO>> getAttributeTypes()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<AttributeTypeDTO> attributeTypes = new List<AttributeTypeDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/AttrTypes/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    attributeTypes = serializer.Deserialize<List<AttributeTypeDTO>>(result);
                }
                return attributeTypes;
            }
        }

        public async Task<AttributeTypeDTO> getAttributeType(string id_type)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                AttributeTypeDTO attributeType = new AttributeTypeDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/AttrTypes/?id_type="+ id_type).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    attributeType = serializer.Deserialize<AttributeTypeDTO>(result);
                }
                return attributeType;
            }
        }

        public async Task<List<GeneralAttributeDTO>> getGeneralAttributes(string categorie_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<GeneralAttributeDTO> generalAttributes = new List<GeneralAttributeDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/generalAttr/?categorie_id="+ categorie_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    generalAttributes = serializer.Deserialize<List<GeneralAttributeDTO>>(result);
                }
                return generalAttributes;
            }
        }
        public async Task<GeneralAttributeDTO> getGeneralAttribute(string id_attribute)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                GeneralAttributeDTO generalAttribute = new GeneralAttributeDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/generalAttr/?id_attribute=" + id_attribute).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    generalAttribute = serializer.Deserialize<GeneralAttributeDTO>(result);
                }
                return generalAttribute;
            }
        }
        public async Task<List<PersonalAttributeDTO>> getPersonalAttributes(string categorie_id)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<PersonalAttributeDTO> personalAttributesDTO = new List<PersonalAttributeDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/personalAttr/?categorie_id=" + categorie_id).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    personalAttributesDTO = serializer.Deserialize<List<PersonalAttributeDTO>>(result);
                }
                return personalAttributesDTO;
            }
        }
        public async Task<PersonalAttributeDTO> getPersonalAttribute(string id_attribute)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                PersonalAttributeDTO personalAttributeDTO = new PersonalAttributeDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/personalAttr/?id_attribute=" + id_attribute).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    personalAttributeDTO = serializer.Deserialize<PersonalAttributeDTO>(result);
                }
                return personalAttributeDTO;
            }
        }
        public async Task<List<AttributeListDTO>> getAttributesList(string id_attribute)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<AttributeListDTO> attributesList = new List<AttributeListDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/attributesList/?id_attribute=" + id_attribute).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    attributesList = serializer.Deserialize<List<AttributeListDTO>>(result);
                }
                return attributesList;
            }
        }
        public async Task<AttributeListDTO> getAttributeList(string id_attributeValue)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                AttributeListDTO attributeList = new AttributeListDTO();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/categories/attributesList/?id_attributeValue=" + id_attributeValue).Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    attributeList = serializer.Deserialize<AttributeListDTO>(result);
                }
                return attributeList;
            }
        }
        //-------------------------------------- Posts --------------------------------------------------
        public async Task<bool> postCategorie(CategorieDTO pCategorieDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pCategorieDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/categories/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> postGeneralAttribute(GeneralAttributeDTO pGeneralAttribute)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pGeneralAttribute);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/categories/generalAttr", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> postPersonalAttribute(PersonalAttributeDTO pPersonalAttributeDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pPersonalAttributeDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/categories/personalAttr", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> postAttributeList(AttributeListDTO pAttributeList)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pAttributeList);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/categories/attributesList", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        //-------------------------------------- Puts --------------------------------------------------
        public async Task<bool> putCategorie(CategorieDTO pCategorieDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pCategorieDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/categories/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> putGeneralAttribute(GeneralAttributeDTO pGeneralAttributeDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pGeneralAttributeDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/categories/generalAttr", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> putPersonalAttribute(PersonalAttributeDTO pPersonalAttributeDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pPersonalAttributeDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/categories/personalAttr", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> putAttributeList(AttributeListDTO pAttributeList)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                var userJson = new JavaScriptSerializer().Serialize(pAttributeList);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PutAsync("api/categories/attributesList", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        //-------------------------------------- Deletes -----------------------------------------------
        public async Task<bool> deleteCategorie(CategorieDTO pCategorieDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/categories/?id_categorie=" + pCategorieDTO.id_categorie).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> deleteGeneralAttribute(GeneralAttributeDTO pGeneralAttributeDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/categories/generalAttr/?id_attribute=" + pGeneralAttributeDTO.id_attribute+"&user="+pGeneralAttributeDTO.user).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> deletePersonalAttribute(PersonalAttributeDTO pPersonalAttributeDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/categories/personalAttr/?id_attribute=" + pPersonalAttributeDTO.id_attribute + "&userLog=" + pPersonalAttributeDTO.userLog).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
        public async Task<bool> deleteAttributeList(AttributeListDTO pAttributeList)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                HttpResponseMessage response = client.DeleteAsync("api/categories/attributesList/?id_attributeValue=" + pAttributeList.id_attributeValue + "&user=" + pAttributeList.user).Result;
                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
        }
    }
}
