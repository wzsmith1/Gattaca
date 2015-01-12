using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using MvcApplication.Models;

namespace MvcApplication.DAL
{
    public class UserContext : DbContext
    {
        public UserContext() : base("DattacaContext")
        {

        }

        public DbSet<User> Users { get; set; }

    }
}