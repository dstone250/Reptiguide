USE [Reptiguide]
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
SELECT B.ReptileListId, B.Stage, B.Note, C.Frequency, D.Category SmallCategory, D.Size SmallFeederSize, E.Category LargeCategory, E.Size LargeFeederSize
FROM [care].[FeedingChartSnake] A
	INNER JOIN [care].[LifeStage] B ON A.LifeStageId = B.LifeStageId
	INNER JOIN [care].[FoodSchedule] C ON C.FoodScheduleId = A.FoodScheduleId
	INNER JOIN [food].[Feeder] D ON D.FeederId = A.FeederIdSmall
	INNER JOIN [food].[Feeder] E ON E.FeederId = A.FeederIdLarge;

GO

