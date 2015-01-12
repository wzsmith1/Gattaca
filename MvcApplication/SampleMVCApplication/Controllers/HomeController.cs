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
        private IFoodRepository foodRepository;

        public HomeController()
        {
            this.foodRepository = new FoodRepository(new NutritionContext());
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
            var foods = from f in foodRepository.GetFoods()
                        select f;
            return View(foods);
        }

    }
}
