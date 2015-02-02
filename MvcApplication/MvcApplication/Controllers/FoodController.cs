using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
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

        //public IEnumerable<Food> Get()
        public IEnumerable<Food> GetFoods(string searchTerm)
        {
            var foods = _repo.GetFoodsBySearchTerm(searchTerm)
                .OrderBy(f => f.Name)
                .Take(25);
            return foods;
        }

        public Food GetFood(int id)
        {
            var food = _repo.GetFoodByID(id);
            return food;
        }
    }
}
