using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MvcApplication.DAL
{
    interface IFoodRepository
    {
        IQueryable<Food> GetFoods();
        IQueryable<Food> GetFoodsBySearchTerm(string searchTerm);
        Food GetFoodByID(int foodID);
    }
}
