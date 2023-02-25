USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE View [guide].[VwDenormalizeReptileList]
AS
/************************************************************************************
View Name: [guide].[VwDenormalizeReptileList]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwDenormalizeReptileList];

Purpose: Denormalize [guide].[DenormalizeReptileList];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT
	 rc.ReptileType
	,rl.species
	,rl.SubSpecies
	,rl.LifeExpectancy
	,fs.Scope 
FROM reptile.ReptileList rl
	INNER JOIN reptile.Category rc ON rl.CategoryId = rc.CategoryId
	INNER JOIN food.FoodScope fs ON rl.FoodScopeId = fs.FoodScopeId;
GO

