﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcApplication.DAL
{
    public class FoodRepository : IFoodRepository, IDisposable
    {
        private NutritionContext context;

        public FoodRepository(NutritionContext context)
        {
            this.context = context;
        }

        public IQueryable<Food> GetFoods()
        {
            return context.Foods;
        }

        public IQueryable<Food> GetFoodsBySearchTerm(string searchTerm)
        {
            return context.Foods.Where(f => f.Name == searchTerm);
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