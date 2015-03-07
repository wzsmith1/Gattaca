using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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

        public IEnumerable<Lookup> GetLookup(string tableName, string searchTerm, int numberOfRecords)
        {
            SqlParameter param1 = new SqlParameter("@TableName", tableName);
            SqlParameter param2 = new SqlParameter("@SearchTerm", searchTerm);
            SqlParameter param3 = new SqlParameter("@NumberOfRecords", numberOfRecords);
            List<Lookup> lookups = context.Lookups.SqlQuery("spLookup @TableName, @SearchTerm, @NumberOfRecords", param1, param2, param3).ToList();
            return lookups;

            //string sql = "SELECT TOP 100 " + tableName + "ID AS LookupID, Name FROM " + tableName + " WHERE Name LIKE '%" + searchTerm + "%'";
            //return context.Lookups.SqlQuery(sql).ToList();
        }

        public Food GetFoodByID(int id)
        {
            return context.Foods.Find(id);
        }

        public Food GetFoodByName(string name)
        {
            return context.Foods.Where(f => f.Name == name).SingleOrDefault();
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