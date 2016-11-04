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
    public class ScriptsProvider : AProvider
    {
        public async Task<List<ScriptsLogDTO>> getScripts()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                List<ScriptsLogDTO> scripts = new List<ScriptsLogDTO>();
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("api/scripts/").Result;
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    serializer.MaxJsonLength = Int32.MaxValue;
                    scripts = serializer.Deserialize<List<ScriptsLogDTO>>(result);
                }
                return scripts;
            }
        }
        //-------------------------------------- Posts --------------------------------------------------

        public async Task<string> postScript(ScriptsLogDTO scriptDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                serializer.MaxJsonLength = Int32.MaxValue;
                var userJson = serializer.Serialize(scriptDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/scripts/", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializerr = new JavaScriptSerializer();
                    serializerr.MaxJsonLength = Int32.MaxValue;
                    return serializer.Deserialize<String>(result);
                }
                return "-1";
            }
        }
        public async Task<string> getScriptResult(ScriptsLogDTO scriptDTO)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(_BaseAddress);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                serializer.MaxJsonLength = Int32.MaxValue;
                var userJson = serializer.Serialize(scriptDTO);
                HttpContent contentPost = new StringContent(userJson, Encoding.UTF8, "application/json");
                HttpResponseMessage response = client.PostAsync("api/scripts/reexecute", contentPost).Result;
                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadAsStringAsync();
                    JavaScriptSerializer serializerr = new JavaScriptSerializer();
                    serializerr.MaxJsonLength = Int32.MaxValue;
                    return serializer.Deserialize<String>(result);
                }
                return "-1";
            }
        }
    }
}
