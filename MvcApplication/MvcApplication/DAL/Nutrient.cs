//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MvcApplication.DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class Nutrient
    {
        public Nutrient()
        {
            this.FoodNutrientCrosses = new HashSet<FoodNutrientCross>();
        }
    
        public int NutrientID { get; set; }
        public string Name { get; set; }
        public string UnitOfMeasure { get; set; }
        public Nullable<int> NumberOfDecimals { get; set; }
    
        public virtual ICollection<FoodNutrientCross> FoodNutrientCrosses { get; set; }
    }
}
