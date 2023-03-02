/******************************************************************************************************************
  Create care Tables
******************************************************************************************************************/

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Substrate](
	[SubstrateId] [smallint] IDENTITY(1,1) NOT NULL,
	[Material] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Substrate] PRIMARY KEY CLUSTERED 
(
	[SubstrateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Substrate] ADD  CONSTRAINT [DF_care_Substrate_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Substrate] ADD  CONSTRAINT [DF_care_Substrate__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [care].[TrSubstrateUpdate]
ON [care].[Substrate]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrSubstrateUpdate
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
	UPDATE [care].[Substrate]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Substrate].SubstrateID = i.SubstrateID
END;
GO

ALTER TABLE [care].[Substrate] ENABLE TRIGGER [TrSubstrateUpdate]
GO





USE [Reptiguide_Empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Environment](
	[EnvironmentId] [smallint] IDENTITY(1,1) NOT NULL,
	[HotSpot_F] [decimal](2, 0) NOT NULL,
	[TempHigh_F] [decimal](2, 0) NOT NULL,
	[TempLow_F] [decimal](2, 0) NOT NULL,
	[HumidityHighPercentage] [decimal](2, 0) NOT NULL,
	[HumidityLowPercentage] [decimal](2, 0) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Environment] PRIMARY KEY CLUSTERED 
(
	[EnvironmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Environment] ADD  CONSTRAINT [DF_care_Environment_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Environment] ADD  CONSTRAINT [DF_care_Environment__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [care].[TrEnvironmentUpdate]
ON [care].[Environment]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrEnvironmentUpdate
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
	UPDATE [care].[Environment]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Environment].EnvironmentID = i.EnvironmentID
END;
GO

ALTER TABLE [care].[Environment] ENABLE TRIGGER [TrEnvironmentUpdate]
GO

USE [Reptiguide_Empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[WaterBowl](
	[WaterBowlId] [smallint] IDENTITY(1,1) NOT NULL,
	[BowlSize] [varchar](50) NOT NULL,
	[Note] [varchar](100) NOT NULL,
	[WaterLevel] [varchar](15) NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_WaterBowl] PRIMARY KEY CLUSTERED 
(
	[WaterBowlId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[WaterBowl] ADD  CONSTRAINT [DF_care_WaterBowl_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[WaterBowl] ADD  CONSTRAINT [DF_care_WaterBowl__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE TRIGGER [care].[TrWaterBowlUpdate]
ON [care].[WaterBowl]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrWaterBowlUpdate
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
	UPDATE [care].[WaterBowl]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[WaterBowl].WaterBowlId = i.WaterBowlId
END;
GO

ALTER TABLE [care].[WaterBowl] ENABLE TRIGGER [TrWaterBowlUpdate]
GO

USE [Reptiguide_Empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[FoodSchedule](
	[FoodScheduleId] [smallint] IDENTITY(1,1) NOT NULL,
	[Frequency] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_FoodSchedule] PRIMARY KEY CLUSTERED 
(
	[FoodScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[FoodSchedule] ADD  CONSTRAINT [DF_care_FoodSchedule_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[FoodSchedule] ADD  CONSTRAINT [DF_care_FoodSchedule__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [care].[TrFoodScheduleUpdate]
ON [care].[FoodSchedule]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrFoodScheduleUpdate
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
	UPDATE [care].[FoodSchedule]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[FoodSchedule].FoodScheduleId = i.FoodScheduleId
END;
GO

ALTER TABLE [care].[FoodSchedule] ENABLE TRIGGER [TrFoodScheduleUpdate]
GO




USE [Reptiguide_Empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Diet](
	[DietId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[FoodScopeId] [tinyint] NOT NULL,
	[WaterBowlId] [varchar](50) NOT NULL,
	[FoodScheduleId] [smallint] NOT NULL,
	[SupplementId] [smallint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Diet] PRIMARY KEY CLUSTERED 
(
	[DietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Diet] ADD  CONSTRAINT [DF_care_Diet_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Diet] ADD  CONSTRAINT [DF_care_Diet__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_care_FoodSchedule] FOREIGN KEY([FoodScheduleId])
REFERENCES [care].[FoodSchedule] ([FoodScheduleId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_care_FoodSchedule]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_food_Supplement] FOREIGN KEY([SupplementId])
REFERENCES [food].[Supplement] ([supplementId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_food_Supplement]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_reptile_Foodscope] FOREIGN KEY([FoodScopeId])
REFERENCES [reptile].[FoodScope] ([FoodScopeId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_reptile_Foodscope]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [care].[TrDietUpdate]
ON [care].[Diet]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrDietUpdate
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
	UPDATE [care].[Diet]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Diet].DietID = i.DietID
END;
GO

ALTER TABLE [care].[Diet] ENABLE TRIGGER [TrDietUpdate]
GO


USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[FeedingChartSnake](
	[FeedingChartSnakeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NULL,
	[LifeStageId] [tinyint] NULL,
	[FoodScheduleId] [smallint] NULL,
	[FeederListIdSmall] [smallint] NULL,
	[FeederListIdLarge] [smallint] NULL,
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

ALTER TABLE [care].[FeedingChartSnake]  WITH CHECK ADD  CONSTRAINT [FK_care_FeedingChartSnake_care_FoodSchedule] FOREIGN KEY([FoodScheduleId])
REFERENCES [care].[FoodSchedule] ([FoodScheduleId])
GO

ALTER TABLE [care].[FeedingChartSnake] CHECK CONSTRAINT [FK_care_FeedingChartSnake_care_FoodSchedule]
GO

ALTER TABLE [care].[FeedingChartSnake]  WITH CHECK ADD  CONSTRAINT [FK_care_FeedingChartSnake_reptile_LifeStage] FOREIGN KEY([LifeStageId])
REFERENCES [reptile].[LifeStage] ([LifeStageId])
GO

ALTER TABLE [care].[FeedingChartSnake] CHECK CONSTRAINT [FK_care_FeedingChartSnake_reptile_LifeStage]
GO

ALTER TABLE [care].[FeedingChartSnake]  WITH CHECK ADD  CONSTRAINT [FK_care_FeedingChartSnake_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [care].[FeedingChartSnake] CHECK CONSTRAINT [FK_care_FeedingChartSnake_reptile_ReptileList]
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

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[FeedingChartNote](
	[FeedingChartNoteId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NULL,
	[Note] [varchar](1500) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_FeedingChartNote] PRIMARY KEY CLUSTERED 
(
	[FeedingChartNoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[FeedingChartNote] ADD  CONSTRAINT [DF__FeedingCha__Note__627A95E8]  DEFAULT ('') FOR [Note]
GO

ALTER TABLE [care].[FeedingChartNote] ADD  CONSTRAINT [DF_care_FeedingChartNote_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[FeedingChartNote] ADD  CONSTRAINT [DF_care_FeedingChartNote__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [care].[FeedingChartNote]  WITH CHECK ADD  CONSTRAINT [FK_care_FeedingChartNote_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [care].[FeedingChartNote] CHECK CONSTRAINT [FK_care_FeedingChartNote_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [care].[TrFeedingChartNoteUpdate]
ON [care].[FeedingChartNote]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrFeedingChartNoteUpdate
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
	UPDATE [care].[FeedingChartNote]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[FeedingChartNote].FeedingChartNoteID = i.FeedingChartNoteID
END;
GO

ALTER TABLE [care].[FeedingChartNote] ENABLE TRIGGER [TrFeedingChartNoteUpdate]
GO


