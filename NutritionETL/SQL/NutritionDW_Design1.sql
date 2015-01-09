--NutritionQueries -> Count is 654,572
WITH Food AS
(
SELECT NDB_No AS FoodID
	, FdGrp_Cd AS FoodGroupID
	, Long_Desc AS Name
	, Shrt_Desc AS ShortName
	, ManufacName AS Manufacturer
	, CASE Survey WHEN 'Y' THEN 1 ELSE 0 END AS HasCompleteProfile
	, Refuse / 100.0 AS RefusePercent
	, Ref_desc AS RefuseDescription
	

	--, ComName AS CommonName
	--, SciName AS ScientificName
	--, N_Factor AS NitrogenFactor
	--, Pro_Factor AS ProteinFactor
	--, Fat_Factor AS FatFactor
	--, CHO_Factor AS CarbohydrateFactor
FROM FOOD_DES
)


, FoodNutrientCross AS
(
SELECT NDB_No AS FoodID
	, Nutr_No AS NutrientID
	, Nutr_Val AS ValuePerHundredGrams
	, CASE Add_Nutr_Mark WHEN 'Y' THEN 1 WHEN 'N' THEN 0 ELSE NULL END AS IsFortified

	--, Num_Data_Pts AS NumberOfDataPoints
	--, Std_Error AS StandardDeviation
	--, Src_Cd AS TypeOfDataID
	--, Deriv_Cd AS DataDerivationID
	--, Ref_NDB_No AS ReferencedFoodID
	--, Num_Studies AS NumberOfStudies
	--, Min AS MinimumValue
	--, Max AS MaximumValue
	--, DF AS DegreeOfFreedom
	--, Low_EB AS Lower95PercentErrorBound
	--, Up_EB AS Upper95PercentErrorBound
	--, Stat_cmt AS StatisticalComments
	--, AddMod_Date AS LastModifiedDate
	--, CC AS ConfidenceCode --for future use
FROM NUT_DATA
)


, Nutrient AS
(
SELECT Nutr_No AS NutrientID
	, NutrDesc AS Name
	, Units AS UnitOfMeasure
	, Num_Dec AS NumberOfDecimals

	--, Tagname AS InternationalTagname
	--, SR_Order AS SortOrder
FROM NUTR_DEF
)


, FoodGroup AS
(
SELECT FdGrp_Cd AS FoodGroupID
	, FdGrp_Desc AS Name
FROM FD_GROUP
)


, FoodWeight AS
(
SELECT NDB_No AS FoodID
	, Amount AS Value
	, Msre_Desc AS UnitOfMeasure
	, Gm_Wgt AS WeightInGrams
	, Seq AS Sequence
	
	--, Num_Data_Pts AS NumberOfDataPoints
	--, Std_Dev AS StandardDeviation
FROM WEIGHT
)


, Footnote_CTE AS --Rename to just "Footnote"
(
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS FootnoteID
	, Footnt_Txt AS Value
FROM (
	SELECT DISTINCT Footnt_Txt
	FROM FOOTNOTE
	) AS FOOTNOTE
)


, FoodFootnoteCross AS
(
SELECT NDB_No AS FoodID
	, FootnoteID
	, CASE Footnt_Typ WHEN 'D' THEN 'Food' WHEN 'M' THEN 'Measure' END AS Type
	
	--, Footnt_No AS SequenceNumber
	--, Nutr_No AS NutrientID
FROM FOOTNOTE
	LEFT OUTER JOIN Footnote_CTE ON FOOTNOTE.Footnt_Txt = Footnote_CTE.Value
WHERE Nutr_No IS NULL
)


, FoodNutrientFootnoteCross AS
(
SELECT NDB_No AS FoodID
	, Nutr_No AS NutrientID
	, FootnoteID
	
	--, Footnt_Type AS Type
	--, Footnt_No AS SequenceNumber
FROM FOOTNOTE
	LEFT OUTER JOIN Footnote_CTE ON FOOTNOTE.Footnt_Txt = Footnote_CTE.Value
WHERE Nutr_No IS NOT NULL
)


, DataSource AS
(
SELECT DataSrc_ID AS DataSourceID
	, Title
	, Authors
	, Journal
	, Year


	--, CASE ISNUMERIC(SUBSTRING(Vol_City, 1, 1)) WHEN 1 THEN Vol_City END AS Volume
	--, CASE ISNUMERIC(SUBSTRING(Vol_City, 1, 1)) WHEN 0 THEN Vol_City END AS City
	--, CASE ISNUMERIC(SUBSTRING(Issue_State, 1, 1)) WHEN 1 THEN Issue_State END AS Issue
	--, CASE ISNUMERIC(SUBSTRING(Issue_State, 1, 1)) WHEN 0 THEN Issue_State END AS State
	--, Start_Page AS StartPage
	--, End_Page AS EndPage
FROM DATA_SRC
)


, FoodNutrientDataSourceCross AS
(
SELECT NDB_No AS FoodID
	, Nutr_No AS NutrientID
	, DataSrc_ID AS DataSourceID
FROM DATSRCLN
)


--, FoodLanguaLCross AS
--(
--SELECT NDB_No AS FoodID
--	, Factor_Code AS LanguaLID
--FROM LANGUAL
--)
--, LanguaL AS --LanguaL Factors (International Food Classifications)
--(
--SELECT Factor_Code AS LanguaLID
--	, Description AS Name
--FROM LANGDESC
--)
--, TypeOfData AS
--(
--SELECT Src_Cd AS TypeOfDataID
--	, SrcCd_Desc AS Value
--FROM SRC_CD
--)
--, DataDerivation AS
--(
--SELECT Deriv_Cd AS DataDerivationID
--	, Deriv_Desc AS Value
--FROM DERIV_CD
--)





SELECT
	Food.FoodID
	, Food.Name
	, Food.ShortName
	, Food.Manufacturer
	, Food.HasCompleteProfile
	, Food.RefusePercent
	, Food.RefuseDescription

	, FoodNutrientCross.ValuePerHundredGrams
	, FoodNutrientCross.IsFortified

	, Nutrient.NutrientID
	, Nutrient.Name
	, Nutrient.UnitOfMeasure
	, Nutrient.NumberOfDecimals

	, FoodGroup.FoodGroupID
	, FoodGroup.Name

	--, FoodWeight.Value
	--, FoodWeight.UnitOfMeasure
	--, FoodWeight.WeightInGrams

	--, Footnote_CTE_Food.FootnoteID
	--, FoodFootnoteCross.Type
	--, Footnote_CTE_Food.Value

	--, DataSource.DataSourceID
	--, DataSource.Title
	--, DataSource.Authors
	--, DataSource.Journal

	--, Footnote_CTE_FoodNutrient.FootnoteID
	--, Footnote_CTE_FoodNutrient.Value

FROM Food
	LEFT OUTER JOIN FoodNutrientCross ON Food.FoodID = FoodNutrientCross.FoodID
	LEFT OUTER JOIN Nutrient ON FoodNutrientCross.NutrientID = Nutrient.NutrientID

	LEFT OUTER JOIN FoodGroup ON Food.FoodGroupID = FoodGroup.FoodGroupID
	--LEFT OUTER JOIN FoodWeight ON Food.FoodID = FoodWeight.FoodID
	--LEFT OUTER JOIN FoodFootnoteCross ON Food.FoodID = FoodFootnoteCross.FoodID
	--LEFT OUTER JOIN Footnote_CTE Footnote_CTE_Food ON FoodFootnoteCross.FootnoteID = Footnote_CTE_Food.FootnoteID

	--LEFT OUTER JOIN FoodNutrientDataSourceCross ON FoodNutrientCross.FoodID = FoodNutrientDataSourceCross.FoodID AND FoodNutrientCross.NutrientID = FoodNutrientDataSourceCross.NutrientID
	--LEFT OUTER JOIN DataSource ON FoodNutrientDataSourceCross.DataSourceID = DataSource.DataSourceID
	--LEFT OUTER JOIN FoodNutrientFootnoteCross ON FoodNutrientCross.FoodID = FoodNutrientFootnoteCross.FoodID AND FoodNutrientCross.NutrientID = FoodNutrientFootnoteCross.NutrientID
	--LEFT OUTER JOIN Footnote_CTE Footnote_CTE_FoodNutrient ON FoodNutrientFootnoteCross.FootnoteID = Footnote_CTE_FoodNutrient.FootnoteID

ORDER BY Food.FoodID


/*
TABLES							FK DEPENDENCIES				LOAD STAGE
----------------------------------------------------------------------------------------------
FoodGroup													1
Nutrient													1
Footnote													1
DataSource													1
Food							FoodGroup					2
FoodWeight						Food						3
FoodNutrientCross				Food, Nutrient				3
FoodFootnoteCross				Food, Footnote				3
FoodNutrientFootnoteCross		Food, Nutrient, Footnote	3
FoodNutrientDataSourceCross		Food, Nutrient, DataSource	3
*/