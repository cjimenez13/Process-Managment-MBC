using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace BeyondThemes.BeyondAdmin.Providers
{
    class AccountProvider : AProvider
    {
        private HttpClient client { get; set; }

        public AccountProvider()
        {
            client = new HttpClient();
            client.BaseAddress = new Uri(WebConfigurationManager.AppSettings["WebApi"]);
        }

        public async Task<string> postToken(string pUserName, string pPassword)
        {
            string token = null;
            var formContent = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("UserName", pUserName),
                new KeyValuePair<string, string>("Password", pPassword),
                new KeyValuePair<string, string>("grant_type", "password")
            });
            HttpResponseMessage response = client.PostAsync("token", formContent).Result;

            if (response.IsSuccessStatusCode)
            {
                string test = await response.Content.ReadAsStringAsync();
                JObject json = JObject.Parse(test);
                token = json.Property("access_token").ToString();
                return token;
            }
            return token;
        }
        public bool logOut()
        {

            return false;
        }
    }
}
