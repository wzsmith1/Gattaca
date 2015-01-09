DELETE FROM FoodNutrientDataSourceCross;
DBCC CHECKIDENT ('FoodNutrientDataSourceCross',RESEED, 0);
DELETE FROM FoodNutrientFootnoteCross;
DBCC CHECKIDENT ('FoodNutrientFootnoteCross',RESEED, 0);

DELETE FROM FoodFootnoteCross;
DBCC CHECKIDENT ('FoodFootnoteCross',RESEED, 0);
DELETE FROM FoodNutrientCross;
DBCC CHECKIDENT ('FoodNutrientCross',RESEED, 0);
DELETE FROM FoodWeight;
DBCC CHECKIDENT ('FoodWeight',RESEED, 0);

DELETE FROM Food;
DBCC CHECKIDENT ('Food',RESEED, 0);

DELETE FROM DataSource;
DBCC CHECKIDENT ('DataSource',RESEED, 0);
DELETE FROM FoodGroup;
DBCC CHECKIDENT ('FoodGroup',RESEED, 0);
DELETE FROM Footnote;
DBCC CHECKIDENT ('Footnote',RESEED, 0);
DELETE FROM Nutrient;
DBCC CHECKIDENT ('Nutrient',RESEED, 0);