﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace BeyondThemes.BeyondAdmin
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");


            routes.MapRoute(
               name: "Default",
               url: "{controller}/{action}/{id}",
               defaults: new { controller = "Processes", action = "Index", id = UrlParameter.Optional }
           );
            routes.MapRoute(
                "Tasks",                                           // Route name
                "Tasks/{id}",                            // URL with parameters
                new { controller = "Tasks", action = "Index" }  // Parameter defaults
            );

        }
    }
}
