USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE View [guide].[VwDenormalizeInformation]
AS
/************************************************************************************
View Name: [guide].[VwDenormalizeInformation]
Created By: David Stone

Parameter List:
N/A

Example:
	SELECT * FROM [guide].[VwDenormalizeInformation];

Purpose: Denormalize [guide].[VwDenormalizeInformation];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT
	 ri.InformationId
	,rc.ReptileType
	,rl.Species
	,rl.SubSpecies
	,CASE ri.isMale
		WHEN 0 THEN 'Female'
		ELSE 'Male'
	END	Sex
	,ri.LifeExpectancy
	,fs.Scope
	,CONCAT(ri.inchesMin/12,''' ',ri.inchesMin%12, '"') [MinLength]
	,CONCAT(ri.inchesMax/12,''' ',ri.inchesMax%12, '"') [MaxLength]
	,CONCAT(ri.lbsMin, ' lbs') MinWeight 
	,CONCAT(ri.lbsMax, ' lbs') MaxWeight
FROM reptile.Information ri
	INNER JOIN reptile.ReptileList rl ON rl.reptilelistID = ri.ReptileListId
	INNER JOIN reptile.Category rc ON ri.CategoryId = rc.CategoryId
	INNER JOIN reptile.FoodScope fs ON ri.FoodScopeId = fs.FoodScopeId;
GO

