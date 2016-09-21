using System;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;

namespace BeyondThemes.BeyondAdmin
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
    public class ValidateLogin : ActionFilterAttribute, IActionFilter
    {
        void IActionFilter.OnActionExecuting(ActionExecutingContext filterContext)
        {
            // TODO: Add your acction filter's tasks here
            string user = "";
            try
            {
                user = filterContext.HttpContext.Request.Cookies["user"].Value;
                if (user == "")
                {
                    filterContext.HttpContext.Request.Cookies["token"].Expires = DateTime.Now.AddDays(-1);
                    FormsAuthentication.SignOut();
                }
            }
            catch(Exception e)
            {
                FormsAuthentication.SignOut();
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Account", action = "Login" }));
            }

        }
    }
}
