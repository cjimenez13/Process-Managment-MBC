using System;
using System.Web.Configuration;
using System.Net.Http;

namespace BeyondThemes.BeyondAdmin.Providers
{
    abstract class AProvider : IProvider
    {
        public HttpClient client { get; set; } 
        public AProvider()
        {
            client = new HttpClient();
            client.BaseAddress = new Uri(WebConfigurationManager.AppSettings["WebApi"]);
        }

        public HttpClient _Client
        {
            get
            {
                return client;
            }

            set
            {
                client = value;
            }
        }
    }
}
