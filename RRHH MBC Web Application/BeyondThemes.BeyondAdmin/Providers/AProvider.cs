using System.Web.Configuration;

namespace BeyondThemes.BeyondAdmin.Providers
{
    public class AProvider
    {
        protected string _BaseAddress = WebConfigurationManager.AppSettings["WebApi"];
    }
}
