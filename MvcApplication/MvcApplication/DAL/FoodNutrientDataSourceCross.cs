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
    
    public partial class FoodNutrientDataSourceCross
    {
        public int FoodNutrientDataSourceCrossID { get; set; }
        public Nullable<int> FoodNutrientCrossID { get; set; }
        public Nullable<int> DataSourceID { get; set; }
    
        public virtual DataSource DataSource { get; set; }
        public virtual FoodNutrientCross FoodNutrientCross { get; set; }
    }
}
