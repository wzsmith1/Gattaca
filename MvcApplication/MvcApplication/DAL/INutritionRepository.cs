using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MvcApplication.DAL
{
    interface INutritionRepository
    {
        IQueryable<Food> GetFoods();
        IEnumerable<Lookup> GetLookup(string tableName, string searchTerm);
        IQueryable<Food> GetFoodsBySearchTerm(string searchTerm);
        Food GetFoodByID(int foodID);
    }
}
