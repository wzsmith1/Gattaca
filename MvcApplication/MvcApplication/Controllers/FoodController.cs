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
            this._repo = new NutritionRepository(new NutritionDBEntities());
        }

        //public IEnumerable<Food> Get()
        public IEnumerable<Food> GetFoods(string searchTerm)
        {
            var foods = _repo.GetFoodsBySearchTerm(searchTerm)
                .OrderBy(f => f.Name)
                .Take(5);
            return foods;
        }

        public IEnumerable<Lookup> GetLookup(string searchTerm)
        {
            int numberOfRecords = 10;
            var foods = _repo.GetLookup("Food", searchTerm, numberOfRecords);
                //.OrderBy(l => l.Name)
                //.Take(10);
            return foods;
        }

        public Food GetFood(int id)
        {
            var food = _repo.GetFoodByID(id);
            return food;
        }

        public Food GetFoodByName(string foodName)
        {
            var food = _repo.GetFoodByName(foodName);
            return food;
        }
    }
}
