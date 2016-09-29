using System.Web.Configuration;

namespace BeyondThemes.BeyondAdmin.Providers
{
    class AProvider
    {
        protected string _BaseAddress = WebConfigurationManager.AppSettings["WebApi"];
    }
}
