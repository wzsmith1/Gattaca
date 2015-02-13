using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcApplication.Models;
using MvcApplication.DAL;

namespace MvcApplication.Controllers
{
    public class HomeController : Controller
    {
        private INutritionRepository _repo;

        public HomeController()
        {
            this._repo = new NutritionRepository(new NutritionContext());
        }

        //
        // GET: /Home/

        public ActionResult Index()
        {
            UserContext db = new UserContext();

            var userList = db.Users.ToList();


            SampleData sample = new SampleData
            {
                id = 1,
                name = "Zach",
                location = "Ann Arbor"
            };
            ViewBag.SampleText = "ViewBag sample text";
            return View(sample);
        }

        public ActionResult Index2()
        {
            var x = 0;
            string searchTerm = "Cranberry";
            var foods = _repo.GetFoodsBySearchTerm(searchTerm)
                .OrderBy(f => f.Name)
                .Take(25);
            return View(foods);
        }

    }
}
