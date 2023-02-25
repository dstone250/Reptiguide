USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [guide].[VwDenormalizeEnvironment] AS
/************************************************************************************
View Name: [guide].[VwDenormalizeEnvironment]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwDenormalizeEnvironment];

Purpose: Denormalize [guide].[DenormalizeEnvironment];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT
	rc.ReptileListId
	,CONCAT(rc.Species, ' ', rc.SubSpecies) AS [ReptileType]
	,re.HotSpot_F     
	,re.TempLow_F     
	,re.TempHigh_F    
	,re.HumidityLowPercentage 
	,re.HumidityHighPercentage
FROM reptile.Environment re
	LEFT JOIN reptile.ReptileList rc ON re.ReptileListId = rc.ReptileListId
GO

