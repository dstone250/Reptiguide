USE [Reptiguide_20230227]
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

