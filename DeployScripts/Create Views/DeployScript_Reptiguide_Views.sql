USE [Reptiguide_empty]
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





USE [Reptiguide_empty]
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






USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [guide].[VwDenormalizeEquipment]
AS
/************************************************************************************
View Name: [guide].[VwDenormalizeEquipment]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwDenormalizeEquipment];

Purpose: Denormalize [guide].[DenormalizeEquipment];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT A.ObjectId, B.CategoryInfo, A.EquipmentName
FROM [equipment].[object] A
	INNER JOIN [equipment].[Category] B ON A.CategoryId = B.CategoryId;
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [guide].[VwDenormalizeFeedingChartSnake] AS
/************************************************************************************
View Name: [guide].[VwDenormalizeFeedingChartSnake]
Created By: David Stone
Parameter List:
N/A
Example:
	SELECT * FROM [guide].[VwDenormalizeFeedingChartSnake]
	WHERE ReptileListId = 1;

Purpose: Denormalize [care].[FeedingChartSnake];
------------------------------------------------------------------------------------
Change History
2023-02-18 David Stone: Created.
************************************************************************************/
SELECT 
B.ReptileListId, 
B.Stage, 
B.Note, 
C.Frequency,
F.Category SmallCategory, 
D.Size SmallFeederSize, 
F.Category  LargeCategory, 
E.Size LargeFeederSize
FROM [care].[FeedingChartSnake] A
	INNER JOIN [reptile].[LifeStage] B ON A.LifeStageId = B.LifeStageId
	INNER JOIN [care].[FoodSchedule] C ON C.FoodScheduleId = A.FoodScheduleId
	INNER JOIN [food].[FeederList] D ON D.FeederListId = A.FeederListIdSmall
	INNER JOIN [food].[FeederList] E ON E.FeederListId = A.FeederListIdLarge
	INNER JOIN [food].[CategoryFeeder] F ON F.CategoryFeederId = D.CategoryFeederId
	INNER JOIN [food].[CategoryFeeder] G ON G.CategoryFeederId = E.CategoryFeederId
GO





USE [Reptiguide_empty]
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





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [guide].[VwReptileListToEquipment]
AS
/************************************************************************************
View Name: [guide].[VwReptileListToEquipment]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwReptileListToEquipment];

Purpose: Denormalize [guide].[ReptileListToEquipment];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT A.ReptileListTobjectId, A.ReptileListId, C.CategoryInfo, B.EquipmentName
FROM [guide].[ReptileListToEquipment] A
	INNER JOIN [equipment].[Object] B ON A.objectId = B.objectId
	INNER JOIN [equipment].category C ON B.categoryId = C.categoryId;
GO

