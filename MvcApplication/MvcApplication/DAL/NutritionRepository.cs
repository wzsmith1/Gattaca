using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcApplication.DAL
{
    public class NutritionRepository : INutritionRepository, IDisposable
    {
        private NutritionDBEntities context;

        public NutritionRepository(NutritionDBEntities context)
        {
            this.context = context;
        }

        public IQueryable<Food> GetFoods()
        {
            return context.Foods;
        }

        public IQueryable<Food> GetFoodsBySearchTerm(string searchTerm)
        {
            return context.Foods.Where(f => f.Name.Contains(searchTerm));
        }

        public IEnumerable<Lookup> GetLookup(string tableName, string searchTerm)
        {
            string sql = "SELECT TOP 100 " + tableName + "ID AS LookupID, Name FROM " + tableName + " WHERE Name LIKE '%" + searchTerm + "%'";
            return context.Lookups.SqlQuery(sql).ToList();
        }

        public Food GetFoodByID(int id)
        {
            return context.Foods.Find(id);
        }

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if(!this.disposed)
            {
                if(disposing)
                {
                    context.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }



    }
}