USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [guide].[VwDenormalizeDiet] 
AS
/************************************************************************************
View Name: [guide].[VwDenormalizeDiet]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwDenormalizeDiet];

Purpose: Denormalize [guide].[DenormalizeDiet];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT
	cd.DietId
	,rc.ReptileListId
	,CONCAT(rc.Species, ': ', rc.SubSpecies) AS [ReptileType]
	,ffs.Scope
	,CASE cwb.Note
		WHEN '' THEN cwb.BowlSize
		 ELSE CONCAT(cwb.BowlSize, ': ', cwb.Note)
	 END AS BowlSize	
	,fs.SupplementName 
	,cfscs.Frequency AS SupplementSchedule
FROM care.Diet cd
	LEFT JOIN reptile.ReptileList rc ON cd.ReptileListId = rc.ReptileListId
	LEFT JOIN reptile.FoodScope ffs ON cd.FoodScopeId = ffs.FoodScopeId
	LEFT JOIN care.WaterBowl cwb ON cd.WaterBowlId = cwb.WaterBowlId
	LEFT JOIN food.supplement fs ON cd.SupplementId = fs.supplementId
	LEFT JOIN care.FoodSchedule cfscs ON cd.FoodScheduleId = cfscs.FoodScheduleId;
GO

