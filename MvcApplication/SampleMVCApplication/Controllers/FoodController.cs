using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using MvcApplication.DAL;

namespace MvcApplication.Controllers
{
    public class FoodController : ApiController
    {
        private INutritionRepository _repo;
        public FoodController()
        {
            this._repo = new NutritionRepository(new NutritionContext());
        }

        public IEnumerable<Food> Get()
        {
            string searchTerm = "Cranberry";
            var foods = _repo.GetFoodsBySearchTerm(searchTerm)
                .OrderBy(f => f.Name)
                .Take(25);
            return foods;
        }
    }
}
