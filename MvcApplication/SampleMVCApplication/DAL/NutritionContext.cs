using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using MvcApplication.Models;

namespace MvcApplication.DAL
{
    public class NutritionContext : DbContext
    {
        public NutritionContext()
            : base("NutritionDB")
        {

        }

        public DbSet<Food> Foods { get; set; }
        public DbSet<Nutrient> Nurients { get; set; }
        

    }
}