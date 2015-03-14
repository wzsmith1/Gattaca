using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Web.Http;

namespace MvcApplication
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            //This line makes the api return calls all JSON format.  Without it I think they return as XML.
            //Don't know if this is a big deal when they're returned to Javascript or not
            config.Formatters.JsonFormatter.SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/html"));

            //config.Routes.MapHttpRoute(
            //    name: "FoodApi",
            //    routeTemplate: "api/Food/GetFood/{id}",
            //    defaults: new { controller = "Food", action = "GetFood", id = RouteParameter.Optional }
            //    );

            config.Routes.MapHttpRoute(
                name: "FoodApi",
                routeTemplate: "api/Food/GetFoodByName/{foodName}",
                defaults: new { controller = "Food", action = "GetFoodByName", foodName = RouteParameter.Optional }
                );

            config.Routes.MapHttpRoute(
                name: "FoodsApi",
                routeTemplate: "api/Food/GetFoods/{searchTerm}",
                defaults: new { controller = "Food", action = "GetFoods", searchTerm = RouteParameter.Optional }
                );

            config.Routes.MapHttpRoute(
                name: "LookupApi",
                routeTemplate: "api/Food/GetLookup/{searchTerm}",
                defaults: new { controller = "Food", action = "GetLookup", searchTerm = RouteParameter.Optional }
                );

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
