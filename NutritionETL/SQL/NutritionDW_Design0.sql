--NutritionQueries -> Count is 654,572
SELECT
	FACT_Food.NDB_No 
	, FACT_Food.Long_Desc

	, DIM_Nutrient.Nutr_No
	, DIM_Nutrient.Nutr_Val
	, DIM_Nutrient.Units
	, DIM_Nutrient.NutrDesc
	, DIM_Nutrient.SrcCd_Desc
	, DIM_Nutrient.Deriv_Desc
	, DIM_Nutrient.Title
	, DIM_Nutrient.Footnt_Txt

	, DIM_FoodGroup.FdGrp_Desc

	, DIM_Weight.[Gm per Meas]

	, DIM_LANGUAL.Description

	, DIM_Footnote.Footnt_Txt

FROM FOOD_DES FACT_Food
	LEFT OUTER JOIN (
		SELECT NUT_DATA.NDB_No
			, NUT_DATA.Nutr_No
			, NUT_DATA.Nutr_Val
			, NUTR_DEF.Units
			, NUTR_DEF.NutrDesc
			, SRC_CD.SrcCd_Desc
			, DERIV_CD.Deriv_Desc
			, DATA_SRC.Title
			, FOOTNOTE.Footnt_Txt
		FROM NUT_DATA
			LEFT OUTER JOIN NUTR_DEF ON NUT_DATA.Nutr_No = NUTR_DEF.Nutr_No
			LEFT OUTER JOIN SRC_CD ON NUT_DATA.Src_Cd = SRC_CD.Src_Cd
			LEFT OUTER JOIN DERIV_CD ON NUT_DATA.Deriv_Cd = DERIV_CD.Deriv_Cd
			LEFT OUTER JOIN (
				SELECT DATSRCLN.NDB_No
					, DATSRCLN.Nutr_No
					, DATA_SRC.Title
				FROM (
						SELECT ROW_NUMBER() OVER (PARTITION BY NDB_No, Nutr_No ORDER BY DataSrc_ID) AS RowNumber
							, NDB_No
							, Nutr_No
							, DataSrc_ID
						FROM DATSRCLN
					) AS DATSRCLN
					LEFT OUTER JOIN DATA_SRC ON DATSRCLN.DataSrc_ID = DATA_SRC.DataSrc_ID
				WHERE RowNumber = 1
			) AS DATA_SRC ON NUT_DATA.NDB_No = DATA_SRC.NDB_No AND NUT_DATA.Nutr_No = DATA_SRC.Nutr_No
			LEFT OUTER JOIN (
				SELECT ROW_NUMBER() OVER (PARTITION BY NDB_No, Nutr_No ORDER BY Footnt_No) AS RowNumber
					, NDB_No
					, Nutr_No
					, Footnt_Txt
				FROM FOOTNOTE
				WHERE Nutr_No IS NOT NULL
			) AS FOOTNOTE ON NUT_DATA.NDB_No = FOOTNOTE.NDB_No AND NUT_DATA.Nutr_No = FOOTNOTE.Nutr_No AND RowNumber = 1			
	) AS DIM_Nutrient ON FACT_Food.NDB_No = DIM_Nutrient.NDB_No
	LEFT OUTER JOIN (
		SELECT FdGrp_Cd
			, FdGrp_Desc
		FROM FD_GROUP
	) AS DIM_FoodGroup ON FACT_Food.FdGrp_Cd = DIM_FoodGroup.FdGrp_Cd
	LEFT OUTER JOIN (
		SELECT NDB_No
			, CAST(Gm_Wgt AS VARCHAR) + '/' + CAST(Amount AS VARCHAR) + ' ' + Msre_Desc AS [Gm per Meas]
		FROM WEIGHT
		WHERE Seq = '1'
	) AS DIM_Weight ON FACT_Food.NDB_No = DIM_Weight.NDB_No
	LEFT OUTER JOIN (
		SELECT NDB_No
			, Description
		FROM (
				SELECT ROW_NUMBER() OVER (PARTITION BY NDB_No ORDER BY Factor_Code) AS RowNumber
					, NDB_No, Factor_Code
				FROM LANGUAL
			) AS LANGUAL
			LEFT OUTER JOIN LANGDESC ON LANGUAL.Factor_Code = LANGDESC.Factor_Code
		WHERE RowNumber = 1
	) AS DIM_LANGUAL ON FACT_Food.NDB_No = DIM_LANGUAL.NDB_No
	--This Table needs to be broken up into Footnotes pertaining to FACT_Food and those Pertaining to DIM_Nutrient
	LEFT OUTER JOIN (
		SELECT NDB_NO
			, Footnt_Txt
		FROM (
				SELECT ROW_NUMBER() OVER (PARTITION BY NDB_No ORDER BY Footnt_No) AS RowNumber
					, NDB_No
					, Footnt_Txt
				FROM FOOTNOTE
				WHERE Nutr_No IS NULL
			) AS FOOTNOTE
		WHERE RowNumber = 1
	) AS DIM_Footnote ON FACT_Food.NDB_No = DIM_Footnote.NDB_No

--ORDER BY FACT_Food.NDB_No
--	, DIM_Nutrient.Nutr_No

/*
NEXT: Review design, some dims/cols might not really be needed (put in separate dim tables or add as needed later?)
Also: idea might be to combine Food and Nutrient together as Fact table? maybe not.
Example: Chicken + Protein, Chicken + Sugar, Bread + Fat, Bread + VitA, etc.
Otherwise keep Food as fact table and nutrient as dim table

*/

/*
SELECT *
FROM NUT_DATA
*/
