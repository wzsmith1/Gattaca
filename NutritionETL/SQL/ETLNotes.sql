--This query shows the values for which there is a Footnote but no matches in the FoodNutrientCross table for some reason.  These rows are ignored in the ETL.
SELECT FOOTNOTE.NDB_No
	, FOOTNOTE.Nutr_No
	--, Footnt_Txt
	, FOOD_DES.Long_Desc
	, NUTR_DEF.NutrDesc
	, fd.FoodID
	, nt.NutrientID
	, fnc.FoodNutrientCrossID
FROM FOOTNOTE
	LEFT OUTER JOIN FOOD_DES ON FOOTNOTE.NDB_No = FOOD_DES.NDB_No
	LEFT OUTER JOIN NUTR_DEF ON FOOTNOTE.Nutr_No = NUTR_DEF.Nutr_No
	LEFT OUTER JOIN NutritionDB.dbo.Food fd ON FOOD_DES.Long_Desc = fd.Name
	LEFT OUTER JOIN NutritionDB.dbo.Nutrient nt ON NUTR_DEF.NutrDesc = nt.Name
	LEFT OUTER JOIN NutritionDB.dbo.FoodNutrientCross fnc ON fd.FoodID = fnc.FoodID AND nt.NutrientID = fnc.NutrientID
WHERE FOOTNOTE.Nutr_No IS NOT NULL
	AND FoodNutrientCrossID IS NULL

SELECT FOOTNOTE.NDB_No
	, FOOTNOTE.Nutr_No
	, FOOD_DES.Long_Desc
	, NUTR_DEF.NutrDesc
	--, NUT_DATA.*
FROM FOOTNOTE
	LEFT OUTER JOIN FOOD_DES ON FOOTNOTE.NDB_No = FOOD_DES.NDB_No
	LEFT OUTER JOIN NUTR_DEF ON FOOTNOTE.Nutr_No = NUTR_DEF.Nutr_No
	LEFT OUTER JOIN NUT_DATA ON FOOTNOTE.NDB_No = NUT_DATA.NDB_No AND FOOTNOTE.Nutr_No = NUT_DATA.Nutr_No
WHERE FOOTNOTE.Nutr_No IS NOT NULL
	AND (NUT_DATA.NDB_No IS NULL AND NUT_DATA.Nutr_No IS NULL)