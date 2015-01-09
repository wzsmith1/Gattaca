--Datachecks
--STAGE1
------------------
--DataSource
SELECT DataSource.Title
	, DataSource.Authors
	, DataSource.Journal
	, DATA_SRC.Title
	, DATA_SRC.Authors
	, DATA_SRC.Journal
FROM DataSource
	FULL OUTER JOIN [Staging_Nutrition].[dbo].[DATA_SRC] DATA_SRC ON (DataSource.Title = DATA_SRC.Title OR (DataSource.Title IS NULL AND DATA_SRC.Title IS NULL))
		AND (DataSource.Authors = DATA_SRC.Authors OR (DataSource.Authors IS NULL AND DATA_SRC.Authors IS NULL))
		AND (DataSource.Journal = DATA_SRC.Journal OR (DataSource.Journal IS NULL AND DATA_SRC.Journal IS NULL))
EXCEPT
SELECT DataSource.Title
	, DataSource.Authors
	, DataSource.Journal
	, DATA_SRC.Title
	, DATA_SRC.Authors
	, DATA_SRC.Journal
FROM DataSource
	INNER JOIN [Staging_Nutrition].[dbo].[DATA_SRC] DATA_SRC ON (DataSource.Title = DATA_SRC.Title OR (DataSource.Title IS NULL AND DATA_SRC.Title IS NULL))
		AND (DataSource.Authors = DATA_SRC.Authors OR (DataSource.Authors IS NULL AND DATA_SRC.Authors IS NULL))
		AND (DataSource.Journal = DATA_SRC.Journal OR (DataSource.Journal IS NULL AND DATA_SRC.Journal IS NULL))

--FoodGroup
SELECT FoodGroup.Name
	, FD_GROUP.FdGrp_Desc
FROM FoodGroup
	FULL OUTER JOIN [Staging_Nutrition].[dbo].[FD_GROUP] FD_GROUP ON FoodGroup.Name = FD_GROUP.FdGrp_Desc
EXCEPT
SELECT FoodGroup.Name
	, FD_GROUP.FdGrp_Desc
FROM FoodGroup
	INNER JOIN [Staging_Nutrition].[dbo].[FD_GROUP] FD_GROUP ON FoodGroup.Name = FD_GROUP.FdGrp_Desc

--Footnote
SELECT Footnote.Value
	, FOOTNOTE2.Footnt_Txt
FROM Footnote
	FULL OUTER JOIN [Staging_Nutrition].[dbo].[FOOTNOTE] FOOTNOTE2 ON Footnote.Value = FOOTNOTE2.Footnt_Txt
EXCEPT
SELECT Footnote.Value
	, FOOTNOTE2.Footnt_Txt
FROM Footnote
	INNER JOIN [Staging_Nutrition].[dbo].[FOOTNOTE] FOOTNOTE2 ON Footnote.Value = FOOTNOTE2.Footnt_Txt

--Nutrient
SELECT Nutrient.Name
	, Nutrient.UnitOfMeasure
	, Nutrient.NumberOfDecimals
	, NUTR_DEF.NutrDesc
	, NUTR_DEF.Units
	, NUTR_DEF.Num_Dec
FROM Nutrient
	FULL OUTER JOIN [Staging_Nutrition].[dbo].[NUTR_DEF] NUTR_DEF ON Nutrient.Name = NUTR_DEF.NutrDesc 
		AND Nutrient.UnitOfMeasure = NUTR_DEF.Units
EXCEPT
SELECT Nutrient.Name
	, Nutrient.UnitOfMeasure
	, Nutrient.NumberOfDecimals
	, NUTR_DEF.NutrDesc
	, NUTR_DEF.Units
	, NUTR_DEF.Num_Dec
FROM Nutrient
	INNER JOIN [Staging_Nutrition].[dbo].[NUTR_DEF] NUTR_DEF ON Nutrient.Name = NUTR_DEF.NutrDesc 
		AND Nutrient.UnitOfMeasure = NUTR_DEF.Units

--STAGE2
------------------
--Food(FoodGroup)
SELECT Food.Name
	, FoodGroup.Name
	, Food.ShortName
	, Food.Manufacturer
	, Food.HasCompleteProfile
	, Food.RefusePercent
	, Food.RefuseDescription
	, FOOD_DES.Long_Desc
	, FD_GROUP.FdGrp_Desc
	, FOOD_DES.Shrt_Desc
	, FOOD_DES.ManufacName
	, FOOD_DES.Survey
	, FOOD_DES.Refuse
	, FOOD_DES.Ref_desc
FROM Food
	FULL OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON Food.Name = FOOD_DES.Long_Desc
	LEFT OUTER JOIN FoodGroup ON Food.FoodGroupID = FoodGroup.FoodGroupID
	LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FD_GROUP] FD_GROUP ON FOOD_DES.FdGrp_Cd = FD_GROUP.FdGrp_Cd
EXCEPT
SELECT Food.Name
	, FoodGroup.Name
	, Food.ShortName
	, Food.Manufacturer
	, Food.HasCompleteProfile
	, Food.RefusePercent
	, Food.RefuseDescription
	, FOOD_DES.Long_Desc
	, FD_GROUP.FdGrp_Desc
	, FOOD_DES.Shrt_Desc
	, FOOD_DES.ManufacName
	, FOOD_DES.Survey
	, FOOD_DES.Refuse
	, FOOD_DES.Ref_desc
FROM Food
	INNER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON Food.Name = FOOD_DES.Long_Desc
	LEFT OUTER JOIN FoodGroup ON Food.FoodGroupID = FoodGroup.FoodGroupID
	LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FD_GROUP] FD_GROUP ON FOOD_DES.FdGrp_Cd = FD_GROUP.FdGrp_Cd

--STAGE3
------------------
--FoodFootnoteCross(Food, Footnote)
SELECT Food.Name
	, Footnote.Value
	, FOOD_DES.Long_Desc
	, FOOTNOTE2.Footnt_Txt
FROM FoodFootnoteCross
	LEFT OUTER JOIN Food ON FoodFootnoteCross.FoodID = Food.FoodID
	LEFT OUTER JOIN Footnote ON FoodFootnoteCross.FootnoteID = Footnote.FootnoteID
	FULL OUTER JOIN [Staging_Nutrition].[dbo].[FOOTNOTE] FOOTNOTE2 ON Footnote.Value = FOOTNOTE2.Footnt_Txt
	LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON FOOTNOTE2.NDB_No = FOOD_DES.NDB_No
WHERE FOOTNOTE2.Nutr_No IS NULL
EXCEPT
SELECT Food.Name
	, Footnote.Value
	, FOOD_DES.Long_Desc
	, FOOTNOTE2.Footnt_Txt
FROM FoodFootnoteCross
	LEFT OUTER JOIN Food ON FoodFootnoteCross.FoodID = Food.FoodID
	LEFT OUTER JOIN Footnote ON FoodFootnoteCross.FootnoteID = Footnote.FootnoteID
	INNER JOIN [Staging_Nutrition].[dbo].[FOOTNOTE] FOOTNOTE2 ON Footnote.Value = FOOTNOTE2.Footnt_Txt
	LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON FOOTNOTE2.NDB_No = FOOD_DES.NDB_No
WHERE FOOTNOTE2.Nutr_No IS NULL

--FoodNutrientCross(Food, Nutrient)
SELECT Food.Name
	, Nutrient.Name
	, Nutrient.UnitOfMeasure
	, FoodNutrientCross.ValuePerHundredGrams
	, FoodNutrientCross.IsFortified
	, NUT_DATA.Long_Desc
	, NUT_DATA.NutrDesc
	, NUT_DATA.Units
	, NUT_DATA.Nutr_Val
	, NUT_DATA.Add_Nutr_Mark
--SELECT COUNT(*)
FROM FoodNutrientCross
	LEFT OUTER JOIN Food ON FoodNutrientCross.FoodID = Food.FoodID
	LEFT OUTER JOIN Nutrient ON FoodNutrientCross.NutrientID = Nutrient.NutrientID
	FULL OUTER JOIN (
		SELECT FOOD_DES.Long_Desc
			, NUTR_DEF.NutrDesc
			, NUTR_DEF.Units
			, NUT_DATA.Nutr_Val
			, NUT_DATA.Add_Nutr_Mark
		FROM [Staging_Nutrition].[dbo].[NUT_DATA] NUT_DATA
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON NUT_DATA.NDB_No = FOOD_DES.NDB_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[NUTR_DEF] NUTR_DEF ON NUT_DATA.Nutr_No = NUTR_DEF.Nutr_No
	) AS NUT_DATA ON Food.Name = NUT_DATA.Long_Desc AND NUT_DATA.NutrDesc = Nutrient.Name AND Nutrient.UnitOfMeasure = NUT_DATA.Units
EXCEPT
SELECT Food.Name
	, Nutrient.Name
	, Nutrient.UnitOfMeasure
	, FoodNutrientCross.ValuePerHundredGrams
	, FoodNutrientCross.IsFortified
	, NUT_DATA.Long_Desc
	, NUT_DATA.NutrDesc
	, NUT_DATA.Units
	, NUT_DATA.Nutr_Val
	, NUT_DATA.Add_Nutr_Mark
FROM FoodNutrientCross
	LEFT OUTER JOIN Food ON FoodNutrientCross.FoodID = Food.FoodID
	LEFT OUTER JOIN Nutrient ON FoodNutrientCross.NutrientID = Nutrient.NutrientID
	INNER JOIN (
		SELECT FOOD_DES.Long_Desc
			, NUTR_DEF.NutrDesc
			, NUTR_DEF.Units
			, NUT_DATA.Nutr_Val
			, NUT_DATA.Add_Nutr_Mark
		FROM [Staging_Nutrition].[dbo].[NUT_DATA] NUT_DATA
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON NUT_DATA.NDB_No = FOOD_DES.NDB_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[NUTR_DEF] NUTR_DEF ON NUT_DATA.Nutr_No = NUTR_DEF.Nutr_No
	) AS NUT_DATA ON Food.Name = NUT_DATA.Long_Desc AND NUT_DATA.NutrDesc = Nutrient.Name AND Nutrient.UnitOfMeasure = NUT_DATA.Units

--FoodWeight(Food)
SELECT Food.Name
	, FoodWeight.Sequence
	, FoodWeight.Value
	, FoodWeight.UnitOfMeasure
	, FoodWeight.WeightInGrams
	, WEIGHT.Long_Desc
	, WEIGHT.Seq
	, WEIGHT.Amount
	, WEIGHT.Msre_Desc
	, WEIGHT.Gm_Wgt
FROM FoodWeight
	LEFT OUTER JOIN Food ON FoodWeight.FoodID = Food.FoodID
	FULL OUTER JOIN (
		SELECT FOOD_DES.Long_Desc
			, WEIGHT.Seq
			, WEIGHT.Amount
			, WEIGHT.Msre_Desc
			, WEIGHT.Gm_Wgt
		FROM [Staging_Nutrition].[dbo].[WEIGHT] WEIGHT
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON WEIGHT.NDB_No = FOOD_DES.NDB_No
	) WEIGHT ON Food.Name = WEIGHT.Long_Desc AND FoodWeight.Sequence = WEIGHT.Seq
EXCEPT
SELECT Food.Name
	, FoodWeight.Sequence
	, FoodWeight.Value
	, FoodWeight.UnitOfMeasure
	, FoodWeight.WeightInGrams
	, WEIGHT.Long_Desc
	, WEIGHT.Seq
	, WEIGHT.Amount
	, WEIGHT.Msre_Desc
	, WEIGHT.Gm_Wgt
FROM FoodWeight
	LEFT OUTER JOIN Food ON FoodWeight.FoodID = Food.FoodID
	INNER JOIN (
		SELECT FOOD_DES.Long_Desc
			, WEIGHT.Seq
			, WEIGHT.Amount
			, WEIGHT.Msre_Desc
			, WEIGHT.Gm_Wgt
		FROM [Staging_Nutrition].[dbo].[WEIGHT] WEIGHT
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON WEIGHT.NDB_No = FOOD_DES.NDB_No
	) WEIGHT ON Food.Name = WEIGHT.Long_Desc AND FoodWeight.Sequence = WEIGHT.Seq

--STAGE4
------------------
--FoodNutrientDataSourceCross(DataSource, FoodNutrientCross)
SELECT Food.Name
	, Nutrient.Name
	, Nutrient.UnitOfMeasure
	, DataSource.Title
	, DataSource.Authors
	, DataSource.Journal
	, DataSource.Year
	, DATSRCLN.Long_Desc
	, DATSRCLN.NutrDesc
	, DATSRCLN.Units
	, DATSRCLN.Title
	, DATSRCLN.Authors
	, DATSRCLN.Journal
	, DATSRCLN.Year
--SELECT COUNT(*)
FROM FoodNutrientDataSourceCross
	LEFT OUTER JOIN FoodNutrientCross ON FoodNutrientDataSourceCross.FoodNutrientCrossID = FoodNutrientCross.FoodNutrientCrossID
	LEFT OUTER JOIN Food ON FoodNutrientCross.FoodID = Food.FoodID
	LEFT OUTER JOIN Nutrient ON FoodNutrientCross.NutrientID = Nutrient.NutrientID
	LEFT OUTER JOIN DataSource ON FoodNutrientDataSourceCross.DataSourceID = DataSource.DataSourceID
	FULL OUTER JOIN (
		SELECT FOOD_DES.Long_Desc
			, NUTR_DEF.NutrDesc
			, NUTR_DEF.Units
			, DATA_SRC.Title
			, DATA_SRC.Authors
			, DATA_SRC.Journal
			, DATA_SRC.Year
		--SELECT COUNT(*)
		FROM [Staging_Nutrition].[dbo].[DATSRCLN] DATSRCLN
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON DATSRCLN.NDB_No = FOOD_DES.NDB_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[NUTR_DEF] NUTR_DEF ON DATSRCLN.Nutr_No = NUTR_DEF.Nutr_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[DATA_SRC] DATA_SRC ON DATSRCLN.DataSrc_ID = DATA_SRC.DataSrc_ID
	) AS DATSRCLN ON Food.Name = DATSRCLN.Long_Desc
		AND Nutrient.Name = DATSRCLN.NutrDesc
		AND Nutrient.UnitOfMeasure = DATSRCLN.Units
		AND (DataSource.Title = DATSRCLN.Title OR (DataSource.Title IS NULL AND DATSRCLN.Title IS NULL))
		AND (DataSource.Authors = DATSRCLN.Authors OR (DataSource.Authors IS NULL AND DATSRCLN.Authors IS NULL))
		AND (DataSource.Journal = DATSRCLN.Journal OR (DataSource.Journal IS NULL AND DATSRCLN.Journal IS NULL))
		AND (DataSource.Year = DATSRCLN.Year OR (DataSource.Year IS NULL AND DATSRCLN.Year IS NULL))
EXCEPT
SELECT Food.Name
	, Nutrient.Name
	, Nutrient.UnitOfMeasure
	, DataSource.Title
	, DataSource.Authors
	, DataSource.Journal
	, DataSource.Year
	, DATSRCLN.Long_Desc
	, DATSRCLN.NutrDesc
	, DATSRCLN.Units
	, DATSRCLN.Title
	, DATSRCLN.Authors
	, DATSRCLN.Journal
	, DATSRCLN.Year
--SELECT COUNT(*)
FROM FoodNutrientDataSourceCross
	LEFT OUTER JOIN FoodNutrientCross ON FoodNutrientDataSourceCross.FoodNutrientCrossID = FoodNutrientCross.FoodNutrientCrossID
	LEFT OUTER JOIN Food ON FoodNutrientCross.FoodID = Food.FoodID
	LEFT OUTER JOIN Nutrient ON FoodNutrientCross.NutrientID = Nutrient.NutrientID
	LEFT OUTER JOIN DataSource ON FoodNutrientDataSourceCross.DataSourceID = DataSource.DataSourceID
	INNER JOIN (
		SELECT FOOD_DES.Long_Desc
			, NUTR_DEF.NutrDesc
			, NUTR_DEF.Units
			, DATA_SRC.Title
			, DATA_SRC.Authors
			, DATA_SRC.Journal
			, DATA_SRC.Year
		--SELECT COUNT(*)
		FROM [Staging_Nutrition].[dbo].[DATSRCLN] DATSRCLN
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON DATSRCLN.NDB_No = FOOD_DES.NDB_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[NUTR_DEF] NUTR_DEF ON DATSRCLN.Nutr_No = NUTR_DEF.Nutr_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[DATA_SRC] DATA_SRC ON DATSRCLN.DataSrc_ID = DATA_SRC.DataSrc_ID
	) AS DATSRCLN ON Food.Name = DATSRCLN.Long_Desc
		AND Nutrient.Name = DATSRCLN.NutrDesc
		AND Nutrient.UnitOfMeasure = DATSRCLN.Units
		AND (DataSource.Title = DATSRCLN.Title OR (DataSource.Title IS NULL AND DATSRCLN.Title IS NULL))
		AND (DataSource.Authors = DATSRCLN.Authors OR (DataSource.Authors IS NULL AND DATSRCLN.Authors IS NULL))
		AND (DataSource.Journal = DATSRCLN.Journal OR (DataSource.Journal IS NULL AND DATSRCLN.Journal IS NULL))
		AND (DataSource.Year = DATSRCLN.Year OR (DataSource.Year IS NULL AND DATSRCLN.Year IS NULL))

--FoodNutrientFootnoteCross(FoodNutrientCross, Footnote)
SELECT Food.Name
	, Nutrient.Name
	, Nutrient.UnitOfMeasure
	, Footnote.Value
	, FOOTNOTE2.Long_Desc
	, FOOTNOTE2.NutrDesc
	, FOOTNOTE2.Units
	, FOOTNOTE2.Footnt_Txt
--SELECT COUNT(*)
FROM FoodNutrientFootnoteCross
	LEFT OUTER JOIN FoodNutrientCross ON FoodNutrientFootnoteCross.FoodNutrientCrossID = FoodNutrientCross.FoodNutrientCrossID
	LEFT OUTER JOIN Food ON FoodNutrientCross.FoodID = Food.FoodID
	LEFT OUTER JOIN Nutrient ON FoodNutrientCross.NutrientID = Nutrient.NutrientID
	LEFT OUTER JOIN Footnote ON FoodNutrientFootnoteCross.FootnoteID = Footnote.FootnoteID
	FULL OUTER JOIN (
		SELECT FOOD_DES.Long_Desc
			, NUTR_DEF.NutrDesc
			, NUTR_DEF.Units
			, FOOTNOTE2.Footnt_Txt
		FROM [Staging_Nutrition].[dbo].[FOOTNOTE] FOOTNOTE2
			INNER JOIN [Staging_Nutrition].[dbo].[NUT_DATA] NUT_DATA ON FOOTNOTE2.NDB_No = NUT_DATA.NDB_No AND FOOTNOTE2.Nutr_No = NUT_DATA.Nutr_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON FOOTNOTE2.NDB_No = FOOD_DES.NDB_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[NUTR_DEF] NUTR_DEF ON FOOTNOTE2.Nutr_No = NUTR_DEF.Nutr_No
		WHERE FOOTNOTE2.Nutr_No IS NOT NULL
	) FOOTNOTE2 ON Food.Name = FOOTNOTE2.Long_Desc
		AND Nutrient.Name = FOOTNOTE2.NutrDesc
		AND Nutrient.UnitOfMeasure = FOOTNOTE2.Units
		AND Footnote.Value = FOOTNOTE2.Footnt_Txt
EXCEPT
SELECT Food.Name
	, Nutrient.Name
	, Nutrient.UnitOfMeasure
	, Footnote.Value
	, FOOTNOTE2.Long_Desc
	, FOOTNOTE2.NutrDesc
	, FOOTNOTE2.Units
	, FOOTNOTE2.Footnt_Txt
--SELECT COUNT(*)
FROM FoodNutrientFootnoteCross
	LEFT OUTER JOIN FoodNutrientCross ON FoodNutrientFootnoteCross.FoodNutrientCrossID = FoodNutrientCross.FoodNutrientCrossID
	LEFT OUTER JOIN Food ON FoodNutrientCross.FoodID = Food.FoodID
	LEFT OUTER JOIN Nutrient ON FoodNutrientCross.NutrientID = Nutrient.NutrientID
	LEFT OUTER JOIN Footnote ON FoodNutrientFootnoteCross.FootnoteID = Footnote.FootnoteID
	INNER JOIN (
		SELECT FOOD_DES.Long_Desc
			, NUTR_DEF.NutrDesc
			, NUTR_DEF.Units
			, FOOTNOTE2.Footnt_Txt
		FROM [Staging_Nutrition].[dbo].[FOOTNOTE] FOOTNOTE2
			INNER JOIN [Staging_Nutrition].[dbo].[NUT_DATA] NUT_DATA ON FOOTNOTE2.NDB_No = NUT_DATA.NDB_No AND FOOTNOTE2.Nutr_No = NUT_DATA.Nutr_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[FOOD_DES] FOOD_DES ON FOOTNOTE2.NDB_No = FOOD_DES.NDB_No
			LEFT OUTER JOIN [Staging_Nutrition].[dbo].[NUTR_DEF] NUTR_DEF ON FOOTNOTE2.Nutr_No = NUTR_DEF.Nutr_No
		WHERE FOOTNOTE2.Nutr_No IS NOT NULL
	) FOOTNOTE2 ON Food.Name = FOOTNOTE2.Long_Desc
		AND Nutrient.Name = FOOTNOTE2.NutrDesc
		AND Nutrient.UnitOfMeasure = FOOTNOTE2.Units
		AND Footnote.Value = FOOTNOTE2.Footnt_Txt











