USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[FeedingChartSnake](
	[FeedingChartSnakeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[LifeStageId] [int] NOT NULL,
	[FoodScheduleId] [varchar](15) NOT NULL,
	[FeederIdSmall] [varchar](15) NOT NULL,
	[FeederIdLarge] [varchar](15) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_FeedingChartSnake] PRIMARY KEY CLUSTERED 
(
	[FeedingChartSnakeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[FeedingChartSnake] ADD  CONSTRAINT [DF_care_FeedingChartSnake_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[FeedingChartSnake] ADD  CONSTRAINT [DF_care_FeedingChartSnake__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [care].[TrFeedingChartSnakeUpdate]
ON [care].[FeedingChartSnake]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrFeedingChartSnakeUpdate
Created By: Dstone
Parameter List
N/A
Output List
N/A
Purpose: Updates the DateUpdated column with the current date/time.

------------------------------------------------------------------------------------
Change History
2022-07-28  Dstone: Created

************************************************************************************/
BEGIN
	UPDATE [care].[FeedingChartSnake]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[FeedingChartSnake].FeedingChartSnakeID = i.FeedingChartSnakeID
END;
GO

ALTER TABLE [care].[FeedingChartSnake] ENABLE TRIGGER [TrFeedingChartSnakeUpdate]
GO

