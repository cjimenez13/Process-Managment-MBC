using System.Web.Configuration;

namespace BeyondThemes.BeyondAdmin.Providers
{
    public class AProvider
    {
        protected string _BaseAddress = WebConfigurationManager.AppSettings["WebApi"];
        public string getToken()
        {
            var token = System.Web.HttpContext.Current.Request.Cookies["token"].Value;
            return token.Substring(17, token.Length - 18);
        }
    }
}
